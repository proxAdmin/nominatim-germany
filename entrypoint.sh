#!/bin/bash
set -e

# Path to the local OSM PBF
OSM_PBF="/nominatim/data.osm.pbf"

# Ensure /nominatim/data exists
mkdir -p /nominatim/data
chown -R root:root /nominatim

# Download Germany PBF if missing
if [ ! -f "$OSM_PBF" ]; then
    echo "Downloading Germany OSM extract..."
    curl -L -o "$OSM_PBF" https://download.geofabrik.de/europe/germany-latest.osm.pbf
else
    echo "OSM PBF already exists at $OSM_PBF, skipping download."
fi

# Export PBF path for Nominatim
export PBF_URL="$OSM_PBF"

# Detect CPU cores for multi-threaded import
THREADS=$(nproc)
export THREADS
echo "Using $THREADS threads for import..."

# Run Nominatim import
/app/init.sh --osmfile "$PBF_URL" --threads "$THREADS"

# Start Nominatim service
exec /app/run.sh
