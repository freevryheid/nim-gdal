# nim-gdal
Nim wrapper for Geospatial Data Abstraction Library (GDAL)

Notes:
The *project* function currently uses the GEOS function which is built into the linux library of libgdal.so. On windows the library (gdal202.dll) doesn't include the GEOS function, so all GEOS functions in the current header should be modified to point to GEOS_c.dll instead. It will make more sense to include the GEOS library functions (including interpolate) as a seperate header.  
