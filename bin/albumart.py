#!/usr/bin/env -S uv run --script
# /// script
# dependencies = [
#   "requests",
# ]
# ///

import os                                                                                                     
import requests                                        
import time                                            
import json                                                                                                   
from pathlib import Path
import urllib.parse                                                                                           
                                                                                                              
# Path to your music collection                                                                               
MUSIC_DIR = "/home/mk/Music/"                                                                  
                                                       
# MusicBrainz API endpoint                                                                                    
MUSICBRAINZ_API = "https://musicbrainz.org/ws/2"                                                              
                                                       
# Cover Art Archive uses MusicBrainz IDs                                                                      
COVERART_API = "https://coverartarchive.org"           
                                                                                                              
# Set headers to be polite with the API                                                                       
HEADERS = {                                            
    'User-Agent': 'MusicCoverArtFetcher/1.0 (mk@406.ch)'  # Replace with your email              
}                                                      
                                                                                                              
def search_musicbrainz(artist_name, album_name):       
    """                                                                                                       
    Search MusicBrainz for album information           
    """                                                                                                       
    # Be nice to the API with a small delay between requests                                                  
    time.sleep(1)                                                                                             
                                                                                                              
    try:                                               
        # URL encode the search terms                  
        query = urllib.parse.quote(f"artist:{artist_name} AND release:{album_name}")                          
                                                       
        # Format the API URL                           
        url = f"{MUSICBRAINZ_API}/release/?query={query}&fmt=json"                                            
                                                                                                              
        response = requests.get(url, headers=HEADERS)                                                         
                                                       
        if response.status_code == 200:                                                                       
            data = response.json()                     
            if data['releases'] and len(data['releases']) > 0:                                                
                # Return the first matching release's ID                                                      
                return data['releases'][0]['id']                                                                                                                                                                            
            else:                                      
                print(f"No MusicBrainz results found for {artist_name} - {album_name}")                       
                return None                                                                                   
        else:                                                                                                 
            print(f"MusicBrainz API error: {response.status_code}")                                           
            return None                                                                                       
    except Exception as e:                                                                                    
        print(f"Error searching MusicBrainz for {artist_name} - {album_name}: {e}")                           
        return None                                                                                           
                                                       
def get_cover_art_url(mb_release_id):                  
    """                                                                                                       
    Get cover art URL from Cover Art Archive using MusicBrainz release ID                                     
    """                                                
    try:                                               
        # Add delay to be kind to the API                                                                     
        time.sleep(1)                                  
                                                       
        url = f"{COVERART_API}/release/{mb_release_id}"                                                       
        response = requests.get(url, headers=HEADERS)                                                         
                                                       
        if response.status_code == 200:                                                                       
            data = response.json()                     
            # Try to find front cover first                                                                   
            for image in data.get('images', []):                                                              
                if image.get('front', False):          
                    return image.get('image')          
                                                                                                              
            # If no front cover, get the first image                                                                                                                                                                        
            if data.get('images') and len(data.get('images')) > 0:                                            
                return data['images'][0].get('image')                                                         
                                                                                                              
        # Handle 404 (no cover art found)                                                                     
        elif response.status_code == 404:              
            print(f"No cover art found for release {mb_release_id}")                                          
            return None                                                                                       
        else:                                          
            print(f"Cover Art Archive API error: {response.status_code}")                                     
            return None                                
    except Exception as e:                                                                                    
        print(f"Error fetching cover art for release {mb_release_id}: {e}")                                   
        return None                                    
                                                                                                              
def save_album_art(image_url, dest_path):              
    """                                                                                                       
    Download and save the album artwork                
    """                                                                                                       
    try:                                               
        response = requests.get(image_url, stream=True)                                                       
        if response.status_code == 200:                                                                       
            with open(dest_path, 'wb') as f:                                                                  
                for chunk in response.iter_content(chunk_size=1024):                                          
                    if chunk:                          
                        f.write(chunk)                 
            print(f"✓ Saved artwork to {dest_path}")                                                          
            return True                                
        else:                                          
            print(f"Failed to download image from {image_url}")                                               
            return False                                                                                      
    except Exception as e:                                                                                    
        print(f"Error saving artwork: {e}")            
        return False                                                                                          
                                                       
def fetch_cover_art(artist_dir, album_dir, album_path, force=False):                                          
    """Process a single album directory to find and save cover art"""                                         
                                                                                                                                                                                                                            
    # Define output file path                          
    cover_path = os.path.join(album_path, "cover.jpg")                                                        
                                                                                                              
    # Skip if cover already exists and not forcing a refresh                                                  
    if os.path.exists(cover_path) and not force:                                                              
        print(f"Cover already exists for {artist_dir} - {album_dir}")                                         
        return True                                                                                           
                                                                                                              
    print(f"Processing: {artist_dir} - {album_dir}")                                                          
                                                       
    # 1. Search MusicBrainz for the release            
    mb_release_id = search_musicbrainz(artist_dir, album_dir)                                                 
    if not mb_release_id:                                                                                     
        return False                                   
                                                       
    # 2. Get cover art URL from Cover Art Archive                                                             
    image_url = get_cover_art_url(mb_release_id)       
    if not image_url:                                  
        return False                                                                                          
                                                                                                              
    # 3. Save the cover art                            
    return save_album_art(image_url, cover_path)                                                              
def main():                                                                                                   
    """Walk through music directory and process each album"""                                                 
                                                       
    # Create a stats counter                           
    stats = {"processed": 0, "success": 0, "failed": 0}                                                       
                                                       
    # Walk through all artist folders                  
    for artist_dir in os.listdir(MUSIC_DIR):           
        artist_path = os.path.join(MUSIC_DIR, artist_dir)                                                     
                                                       
        # Skip if not a directory                      
        if not os.path.isdir(artist_path):             
            continue                                   
                                                       
        # Process each album folder                    
        for album_dir in os.listdir(artist_path):      
            album_path = os.path.join(artist_path, album_dir)                                                 
                                                       
            # Skip if not a directory                  
            if not os.path.isdir(album_path):          
                continue                               
                                                       
            stats["processed"] += 1                    
            result = fetch_cover_art(artist_dir, album_dir, album_path)                                       
                                                       
            if result:                                 
                stats["success"] += 1                  
            else:                                      
                stats["failed"] += 1                   
                                                       
    # Print stats                                      
    print("\n--- Cover Art Fetching Complete ---")     
    print(f"Processed: {stats['processed']} albums")   
    print(f"Successful: {stats['success']} albums")    
    print(f"Failed: {stats['failed']} albums")         

if __name__ == "__main__":                             
    main()         
