import os
import json

def create_symlinks_from_json(json_file):
    # Read the JSON file
    with open(json_file, 'r') as f:
        data = json.load(f)

    # Iterate over the list of dictionaries in the JSON
    for entry in data:
        where = entry.get("link")
        file_relative_path = entry.get("file")
        force = entry.get("force", False)  # Default to False if not specified

        # Get the absolute path by combining DFOX_PATH and the relative path
        dfox_path = os.environ.get("DFOX_PATH")
        file_path = os.path.join(dfox_path, file_relative_path)

        # Check if the file exists at the specified location
        if os.path.exists(file_path):
            # Generate the symlink at the specified location
            where = where.replace('~', os.path.expanduser("~"))
            symlink_path = os.path.join(where, os.path.basename(file_path))
            
            # Check if symlink already exists
            if os.path.exists(symlink_path) or os.path.islink(symlink_path):
                if force:
                    # Remove existing file/symlink if force is true
                    if os.path.islink(symlink_path):
                        os.unlink(symlink_path)
                        print(f"Removed existing symlink at {symlink_path}")
                    else:
                        os.remove(symlink_path)
                        print(f"Removed existing file at {symlink_path}")
                else:
                    print(f"Warning: Symbolic link already exists at {symlink_path}, skipping...")
                    continue
            
            # Create the directory if it doesn't exist
            os.makedirs(where, exist_ok=True)
            os.symlink(file_path, symlink_path)
            print(f"Symbolic link created at {symlink_path}")
        else:
            print(f"Could not find the file {file_path}")

if __name__ == "__main__":
    # Path to the JSON file
    json_file = 'symlinks/general.json'
    
    # Call the function to create the symbolic links
    create_symlinks_from_json(json_file)
