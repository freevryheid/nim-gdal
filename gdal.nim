# TODO: Check if named cstring parameters are in fact ptr cstring

when defined(windows):
  const libgdal = "libgdal.dll"
elif defined(macosx):
  const libgdal = "libgdal.dylib"
else:
  const libgdal = "libgdal.so"

import math

type
  Dataset* = pointer
  Layer* = pointer
  Feature* = pointer
  FeatureDefn* = pointer
  FieldDefn* = pointer
  Geometry* = pointer
  SpatialReference* = pointer
  CoordinateTransformation* = pointer
  Access* = enum
    ReadOnly               ## Read only (no update) access
    Update                 ## Read/write access
  FieldType* = enum
    Integer                ## Simple 32bit integer.
    IntegerList            ## List of 32bit integers.
    Real                   ## Double Precision floating point.
    RealList               ## List of doubles.
    String                 ## String of ASCII chars.
    StringList             ## Array of strings.
    WideString             ## deprecated
    WideStringList         ## deprecated
    Binary                 ## Raw Binary data.
    Date                   ## Date.
    Time                   ## Time.
    DateTime               ## Date and Time.
    Integer64              ## Single 64bit integer.
    Integer64List          ## List of 64bit integers.
  GeometryType* = enum
    Unknown                ## unknown type, non-standard
    Point                  ## 0-dimensional geometric object, standard WKB
    LineString             ## 1-dimensional geometric object with linear interpolation between Points, standard WKB
    Polygon                ## planar 2-dimensional geometric object defined by 1 exterior boundary and 0 or more interior boundaries, standard WKB
    MultiPoint             ## GeometryCollection of Points, standard WKB.
    MultiLineString        ## GeometryCollection of LineStrings, standard WKB.
    MultiPolygon           ## GeometryCollection of Polygons, standard WKB.
    GeometryCollection     ## geometric object that is a collection of 1 or more geometric objects, standard WKB
    CircularString         ## one or more circular arc segments connected end to end, ISO SQL/MM Part 3. GDAL >= 2.0
    CompoundCurve          ## sequence of contiguous curves, ISO SQL/MM Part 3. GDAL >= 2.0
    CurvePolygon           ## planar surface, defined by 1 exterior boundary and zero or more interior boundaries, that are curves. ISO SQL/MM Part 3. GDAL >= 2.0
    MultiCurve             ## GeometryCollection of Curves, ISO SQL/MM Part 3. GDAL >= 2.0
    MultiSurface           ## GeometryCollection of Surfaces, ISO SQL/MM Part 3. GDAL >= 2.0
    Curve                  ## Curve (abstract type). ISO SQL/MM Part 3. GDAL >= 2.1
    Surface                ## Surface (abstract type). ISO SQL/MM Part 3. GDAL >= 2.1
    PolyhedralSurface      ## a contiguous collection of polygons, which share common boundary segments, ISO SQL/MM Part 3. Reserved in GDAL >= 2.1 but not yet implemented
    TIN                    ## a PolyhedralSurface consisting only of Triangle patches ISO SQL/MM Part 3. Reserved in GDAL >= 2.1 but not yet implemented
    Triangle               ## a Triangle. ISO SQL/MM Part 3. Reserved in GDAL >= 2.1 but not yet implemented
    None                   ## non-standard, for pure attribute records
    LinearRing             ## non-standard, just for createGeometry()
    CircularStringZ        ## wkbCircularString with Z component. ISO SQL/MM Part 3. GDAL >= 2.0
    CompoundCurveZ         ## wkbCompoundCurve with Z component. ISO SQL/MM Part 3. GDAL >= 2.0
    CurvePolygonZ          ## wkbCurvePolygon with Z component. ISO SQL/MM Part 3. GDAL >= 2.0
    MultiCurveZ            ## wkbMultiCurve with Z component. ISO SQL/MM Part 3. GDAL >= 2.0
    MultiSurfaceZ          ## wkbMultiSurface with Z component. ISO SQL/MM Part 3. GDAL >= 2.0
    CurveZ                 ## wkbCurve with Z component. ISO SQL/MM Part 3. GDAL >= 2.1
    SurfaceZ               ## wkbSurface with Z component. ISO SQL/MM Part 3. GDAL >= 2.1
    PolyhedralSurfaceZ     ## ISO SQL/MM Part 3. Reserved in GDAL >= 2.1 but not yet implemented
    TINZ                   ## ISO SQL/MM Part 3. Reserved in GDAL >= 2.1 but not yet implemented
    TriangleZ              ## ISO SQL/MM Part 3. Reserved in GDAL >= 2.1 but not yet implemented
    PointM                 ## ISO SQL/MM Part 3. GDAL >= 2.1
    LineStringM            ## ISO SQL/MM Part 3. GDAL >= 2.1
    PolygonM               ## ISO SQL/MM Part 3. GDAL >= 2.1
    MultiPointM            ## ISO SQL/MM Part 3. GDAL >= 2.1
    MultiLineStringM       ## ISO SQL/MM Part 3. GDAL >= 2.1
    MultiPolygonM          ## ISO SQL/MM Part 3. GDAL >= 2.1
    GeometryCollectionM    ## ISO SQL/MM Part 3. GDAL >= 2.1
    CircularStringM        ## ISO SQL/MM Part 3. GDAL >= 2.1
    CompoundCurveM         ## ISO SQL/MM Part 3. GDAL >= 2.1
    CurvePolygonM          ## ISO SQL/MM Part 3. GDAL >= 2.1
    MultiCurveM            ## ISO SQL/MM Part 3. GDAL >= 2.1
    MultiSurfaceM          ## ISO SQL/MM Part 3. GDAL >= 2.1
    CurveM                 ## ISO SQL/MM Part 3. GDAL >= 2.1
    SurfaceM               ## ISO SQL/MM Part 3. GDAL >= 2.1
    PolyhedralSurfaceM     ## ISO SQL/MM Part 3. Reserved in GDAL >= 2.1 but not yet implemented
    TINM                   ## ISO SQL/MM Part 3. Reserved in GDAL >= 2.1 but not yet implemented
    TriangleM              ## ISO SQL/MM Part 3. Reserved in GDAL >= 2.1 but not yet implemented
    PointZM                ## ISO SQL/MM Part 3. GDAL >= 2.1
    LineStringZM           ## ISO SQL/MM Part 3. GDAL >= 2.1
    PolygonZM              ## ISO SQL/MM Part 3. GDAL >= 2.1
    MultiPointZM           ## ISO SQL/MM Part 3. GDAL >= 2.1
    MultiLineStringZM      ## ISO SQL/MM Part 3. GDAL >= 2.1
    MultiPolygonZM         ## ISO SQL/MM Part 3. GDAL >= 2.1
    GeometryCollectionZM   ## ISO SQL/MM Part 3. GDAL >= 2.1
    CircularStringZM       ## ISO SQL/MM Part 3. GDAL >= 2.1
    CompoundCurveZM        ## ISO SQL/MM Part 3. GDAL >= 2.1
    CurvePolygonZM         ## ISO SQL/MM Part 3. GDAL >= 2.1
    MultiCurveZM           ## ISO SQL/MM Part 3. GDAL >= 2.1
    MultiSurfaceZM         ## ISO SQL/MM Part 3. GDAL >= 2.1
    CurveZM                ## ISO SQL/MM Part 3. GDAL >= 2.1
    SurfaceZM              ## ISO SQL/MM Part 3. GDAL >= 2.1
    PolyhedralSurfaceZM    ## ISO SQL/MM Part 3. Reserved in GDAL >= 2.1 but not yet implemented
    TINZM                  ## ISO SQL/MM Part 3. Reserved in GDAL >= 2.1 but not yet implemented
    TriangleZM             ## ISO SQL/MM Part 3. Reserved in GDAL >= 2.1 but not yet implemented
    Point25D               ## 2.5D extension as per 99-402
    LineString25D          ## 2.5D extension as per 99-402
    Polygon25D             ## 2.5D extension as per 99-402
    MultiPoint25D          ## 2.5D extension as per 99-402
    MultiLineString25D     ## 2.5D extension as per 99-402
    MultiPolygon25D        ## 2.5D extension as per 99-402
    GeometryCollection25D  ## 2.5D extension as per 99-402

const
  OF_READONLY* = 0x00  ## Open in read-only mode.
  OF_UPDATE* = 0x01  ## Open in read/write mode.
  OF_VECTOR* = 0x04  ## Allow vector drivers to be used.
  WKT_WGS84 = "GEOGCS[\"WGS 84\",DATUM[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"9122\"]],AUTHORITY[\"EPSG\",\"4326\"]]"  ## WGS 84 geodetic (long/lat) WKT / EPSG:4326 with long,lat ordering
  PT_ALBERS_CONIC_EQUAL_AREA = "Albers_Conic_Equal_Area"  ## Albers_Conic_Equal_Area projection
  PT_AZIMUTHAL_EQUIDISTANT = "Azimuthal_Equidistant"  ## Azimuthal_Equidistant projection
  PT_CASSINI_SOLDNER = "Cassini_Soldner"  ## Cassini_Soldner projection
  PT_CYLINDRICAL_EQUAL_AREA = "Cylindrical_Equal_Area"  ## Cylindrical_Equal_Area projection 
  PT_BONNE = "Bonne"  ## Cylindrical_Equal_Area projection 
  PT_ECKERT_I = "Eckert_I"  ## Eckert_I projection 
  PT_ECKERT_II = "Eckert_II"  ## Eckert_II projection 
  PT_ECKERT_III = "Eckert_III"  ## Eckert_III projection 
  PT_ECKERT_IV = "Eckert_IV"  ## Eckert_IV projection 
  PT_ECKERT_V = "Eckert_V"  ## Eckert_V projection 
  PT_ECKERT_VI = "Eckert_VI"  ## Eckert_VI projection 
  PT_EQUIDISTANT_CONIC = "Equidistant_Conic"  ## Equidistant_Conic projection 
  PT_EQUIRECTANGULAR = "Equirectangular"  ## Equirectangular projection 
  PT_GALL_STEREOGRAPHIC = "Gall_Stereographic"  ## Gall_Stereographic projection 
  PT_GAUSSSCHREIBERTMERCATOR = "Gauss_Schreiber_Transverse_Mercator"  ## Gauss_Schreiber_Transverse_Mercator projection 
  PT_GEOSTATIONARY_SATELLITE = "Geostationary_Satellite"  ## Geostationary_Satellite projection 
  PT_GOODE_HOMOLOSINE = "Goode_Homolosine"  ## Goode_Homolosine projection 
  PT_IGH = "Interrupted_Goode_Homolosine"  ## Interrupted_Goode_Homolosine projection 
  PT_GNOMONIC = "Gnomonic"  ## Gnomonic projection 
  PT_HOTINE_OBLIQUE_MERCATOR_AZIMUTH_CENTER = "Hotine_Oblique_Mercator_Azimuth_Center"  ## Hotine_Oblique_Mercator_Azimuth_Center projection 
  PT_HOTINE_OBLIQUE_MERCATOR = "Hotine_Oblique_Mercator"  ## Hotine_Oblique_Mercator projection 
  PT_HOTINE_OBLIQUE_MERCATOR_TWO_POINT_NATURAL_ORIGIN = "Hotine_Oblique_Mercator_Two_Point_Natural_Origin"  ## Hotine_Oblique_Mercator_Two_Point_Natural_Origin projection 
  PT_LABORDE_OBLIQUE_MERCATOR = "Laborde_Oblique_Mercator"  ## Laborde_Oblique_Mercator projection 
  PT_LAMBERT_CONFORMAL_CONIC_1SP = "Lambert_Conformal_Conic_1SP"  ## Lambert_Conformal_Conic_1SP projection 
  PT_LAMBERT_CONFORMAL_CONIC_2SP = "Lambert_Conformal_Conic_2SP"  ## Lambert_Conformal_Conic_2SP projection 
  PT_LAMBERT_CONFORMAL_CONIC_2SP_BELGIUM = "Lambert_Conformal_Conic_2SP_Belgium"  ## Lambert_Conformal_Conic_2SP_Belgium projection 
  PT_LAMBERT_AZIMUTHAL_EQUAL_AREA = "Lambert_Azimuthal_Equal_Area"  ## Lambert_Azimuthal_Equal_Area projection 
  PT_MERCATOR_1SP = "Mercator_1SP"  ## Mercator_1SP projection 
  PT_MERCATOR_2SP = "Mercator_2SP"  ## Mercator_2SP projection 
  PT_MERCATOR_AUXILIARY_SPHERE = "Mercator_Auxiliary_Sphere"  ## Mercator_Auxiliary_Sphere is used used by ESRI to mean EPSG:3875 
  PT_MILLER_CYLINDRICAL = "Miller_Cylindrical"  ## Miller_Cylindrical projection 
  PT_MOLLWEIDE = "Mollweide"  ## Mollweide projection 
  PT_NEW_ZEALAND_MAP_GRID = "New_Zealand_Map_Grid"  ## New_Zealand_Map_Grid projection 
  PT_OBLIQUE_STEREOGRAPHIC = "Oblique_Stereographic"  ## Oblique_Stereographic projection 
  PT_ORTHOGRAPHIC = "Orthographic"  ## Orthographic projection 
  PT_POLAR_STEREOGRAPHIC = "Polar_Stereographic"  ## Polar_Stereographic projection 
  PT_POLYCONIC = "Polyconic"  ## Polyconic projection 
  PT_ROBINSON = "Robinson"  ## Robinson projection 
  PT_SINUSOIDAL = "Sinusoidal"  ## Sinusoidal projection 
  PT_STEREOGRAPHIC = "Stereographic"  ## Stereographic projection 
  PT_SWISS_OBLIQUE_CYLINDRICAL = "Swiss_Oblique_Cylindrical"  ## Swiss_Oblique_Cylindrical projection 
  PT_TRANSVERSE_MERCATOR = "Transverse_Mercator"  ## Transverse_Mercator projection 
  PT_TRANSVERSE_MERCATOR_SOUTH_ORIENTED = "Transverse_Mercator_South_Orientated"  ## Transverse_Mercator_South_Orientated projection 
  PT_TRANSVERSE_MERCATOR_MI_21 = "Transverse_Mercator_MapInfo_21"  ## Transverse_Mercator_MapInfo_21 projection 
  PT_TRANSVERSE_MERCATOR_MI_22 = "Transverse_Mercator_MapInfo_22"  ## Transverse_Mercator_MapInfo_22 projection 
  PT_TRANSVERSE_MERCATOR_MI_23 = "Transverse_Mercator_MapInfo_23"  ## Transverse_Mercator_MapInfo_23 projection 
  PT_TRANSVERSE_MERCATOR_MI_24 = "Transverse_Mercator_MapInfo_24"  ## Transverse_Mercator_MapInfo_24 projection 
  PT_TRANSVERSE_MERCATOR_MI_25 = "Transverse_Mercator_MapInfo_25"  ## Transverse_Mercator_MapInfo_25 projection 
  PT_TUNISIA_MINING_GRID = "Tunisia_Mining_Grid"  ## Tunisia_Mining_Grid projection 
  PT_TWO_POINT_EQUIDISTANT = "Two_Point_Equidistant"  ## Two_Point_Equidistant projection 
  PT_VANDERGRINTEN = "VanDerGrinten"  ## VanDerGrinten projection 
  PT_KROVAK = "Krovak"  ## Krovak projection 
  PT_IMW_POLYCONIC = "International_Map_of_the_World_Polyconic"  ## International_Map_of_the_World_Polyconic projection 
  PT_WAGNER_I = "Wagner_I"  ## Wagner_I projection 
  PT_WAGNER_II = "Wagner_II"  ## Wagner_II projection 
  PT_WAGNER_III = "Wagner_III"  ## Wagner_III projection 
  PT_WAGNER_IV = "Wagner_IV"  ## Wagner_IV projection 
  PT_WAGNER_V = "Wagner_V"  ## Wagner_V projection 
  PT_WAGNER_VI = "Wagner_VI"  ## Wagner_VI projection 
  PT_WAGNER_VII = "Wagner_VII"  ## Wagner_VII projection 
  PT_QSC = "Quadrilateralized_Spherical_Cube"  ## Quadrilateralized_Spherical_Cube projection 
  PT_AITOFF = "Aitoff"  ## Aitoff projection 
  PT_WINKEL_I = "Winkel_I"  ## Winkel_I projection 
  PT_WINKEL_II = "Winkel_II"  ## Winkel_II projection 
  PT_WINKEL_TRIPEL = "Winkel_Tripel"  ## Winkel_Tripel projection 
  PT_CRASTER_PARABOLIC = "Craster_Parabolic"  ## Craster_Parabolic projection 
  PT_LOXIMUTHAL = "Loximuthal"  ## Loximuthal projection 
  PT_QUARTIC_AUTHALIC = "Quartic_Authalic"  ## Quartic_Authalic projection 
  PT_SCH = "Spherical_Cross_Track_Height"  ## Spherical_Cross_Track_Height projection 
  PP_CENTRAL_MERIDIAN = "central_meridian"  ## central_meridian projection paramete 
  PP_SCALE_FACTOR = "scale_factor"  ## scale_factor projection paramete 
  PP_STANDARD_PARALLEL_1 = "standard_parallel_1"  ## standard_parallel_1 projection paramete 
  PP_STANDARD_PARALLEL_2 = "standard_parallel_2"  ## standard_parallel_2 projection paramete 
  PP_PSEUDO_STD_PARALLEL_1 = "pseudo_standard_parallel_1"  ## pseudo_standard_parallel_1 projection paramete 
  PP_LONGITUDE_OF_CENTER = "longitude_of_center"  ## longitude_of_center projection paramete 
  PP_LATITUDE_OF_CENTER = "latitude_of_center"  ## latitude_of_center projection paramete 
  PP_LONGITUDE_OF_ORIGIN = "longitude_of_origin"  ## longitude_of_origin projection paramete 
  PP_LATITUDE_OF_ORIGIN = "latitude_of_origin"  ## latitude_of_origin projection paramete 
  PP_FALSE_EASTING = "false_easting"  ## false_easting projection paramete 
  PP_FALSE_NORTHING = "false_northing"  ## false_northing projection paramete 
  PP_AZIMUTH = "azimuth"  ## azimuth projection paramete 
  PP_LONGITUDE_OF_POINT_1 = "longitude_of_point_1"  ## longitude_of_point_1 projection paramete 
  PP_LATITUDE_OF_POINT_1 = "latitude_of_point_1"  ## latitude_of_point_1 projection paramete 
  PP_LONGITUDE_OF_POINT_2 = "longitude_of_point_2"  ## longitude_of_point_2 projection paramete 
  PP_LATITUDE_OF_POINT_2 = "latitude_of_point_2"  ## latitude_of_point_2 projection paramete 
  PP_LONGITUDE_OF_POINT_3 = "longitude_of_point_3"  ## longitude_of_point_3 projection paramete 
  PP_LATITUDE_OF_POINT_3 = "latitude_of_point_3"  ## latitude_of_point_3 projection paramete 
  PP_RECTIFIED_GRID_ANGLE = "rectified_grid_angle"  ## rectified_grid_angle projection paramete 
  PP_LANDSAT_NUMBER = "landsat_number"  ## landsat_number projection paramete 
  PP_PATH_NUMBER = "path_number"  ## path_number projection paramete 
  PP_PERSPECTIVE_POINT_HEIGHT = "perspective_point_height"  ## perspective_point_height projection paramete 
  PP_SATELLITE_HEIGHT = "satellite_height"  ## satellite_height projection paramete 
  PP_FIPSZONE = "fipszone"  ## fipszone projection paramete 
  PP_ZONE = "zone"  ## zone projection paramete 
  PP_LATITUDE_OF_1ST_POINT = "Latitude_Of_1st_Point"  ## Latitude_Of_1st_Point projection parameter 
  PP_LONGITUDE_OF_1ST_POINT = "Longitude_Of_1st_Point"  ## Longitude_Of_1st_Point projection parameter 
  PP_LATITUDE_OF_2ND_POINT = "Latitude_Of_2nd_Point"  ## Latitude_Of_2nd_Point projection parameter 
  PP_LONGITUDE_OF_2ND_POINT = "Longitude_Of_2nd_Point"  ## Longitude_Of_2nd_Point projection parameter 
  PP_PEG_POINT_LATITUDE = "peg_point_latitude"  ## peg_point_latitude projection paramete 
  PP_PEG_POINT_LONGITUDE = "peg_point_longitude"  ## peg_point_longitude projection paramete 
  PP_PEG_POINT_HEADING = "peg_point_heading"  ## peg_point_heading projection paramete 
  PP_PEG_POINT_HEIGHT = "peg_point_height"  ## peg_point_height projection paramete 
  UL_METER = "Meter"  ## Linear unit Meter 
  UL_FOOT = "Foot (International)"  ## or just "FOOT"?, Linear unit Foot (International 
  UL_FOOT_CONV = "0.3048"  ## Linear unit Foot (International) conversion factor to meter 
  UL_US_FOOT = "Foot_US"  ## or "US survey foot" from EPSG, Linear unit Foot 
  UL_US_FOOT_CONV = "0.3048006096012192"  ## Linear unit Foot conversion factor to meter 
  UL_NAUTICAL_MILE = "Nautical Mile"  ## Linear unit Nautical Mile 
  UL_NAUTICAL_MILE_CONV = "1852.0"  ## Linear unit Nautical Mile conversion factor to meter 
  UL_LINK = "Link"  ## Based on US Foot, Linear unit Link 
  UL_LINK_CONV = "0.20116684023368047"  ## Linear unit Link conversion factor to meter 
  UL_CHAIN = "Chain"  ## based on US Foot, Linear unit Chain 
  UL_CHAIN_CONV = "20.116684023368047"  ## Linear unit Chain conversion factor to meter 
  UL_ROD = "Rod"  ## based on US Foot, Linear unit Rod 
  UL_ROD_CONV = "5.02921005842012"  ## Linear unit Rod conversion factor to meter 
  UL_LINK_Clarke = "Link_Clarke"  ## Linear unit Link_Clarke 
  UL_LINK_Clarke_CONV = "0.2011661949"  ## Linear unit Link_Clarke conversion factor to meter 
  UL_KILOMETER = "Kilometer"  ## Linear unit Kilometer 
  UL_KILOMETER_CONV = "1000."  ## Linear unit Kilometer conversion factor to meter 
  UL_DECIMETER = "Decimeter"  ## Linear unit Decimeter 
  UL_DECIMETER_CONV = "0.1"  ## Linear unit Decimeter conversion factor to meter 
  UL_CENTIMETER = "Centimeter"  ## Linear unit Decimeter 
  UL_CENTIMETER_CONV = "0.01"  ## Linear unit Decimeter conversion factor to meter 
  UL_MILLIMETER = "Millimeter"  ## Linear unit Millimeter 
  UL_MILLIMETER_CONV = "0.001"  ## Linear unit Millimeter conversion factor to meter 
  UL_INTL_NAUT_MILE = "Nautical_Mile_International"  ## Linear unit Nautical_Mile_International 
  UL_INTL_NAUT_MILE_CONV = "1852.0"  ## Linear unit Nautical_Mile_International conversion factor to meter 
  UL_INTL_INCH = "Inch_International"  ## Linear unit Inch_International 
  UL_INTL_INCH_CONV = "0.0254"  ## Linear unit Inch_International conversion factor to meter 
  UL_INTL_FOOT = "Foot_International"  ## Linear unit Foot_International 
  UL_INTL_FOOT_CONV = "0.3048"  ## Linear unit Foot_International conversion factor to meter 
  UL_INTL_YARD = "Yard_International"  ## Linear unit Yard_International 
  UL_INTL_YARD_CONV = "0.9144"  ## Linear unit Yard_International conversion factor to meter 
  UL_INTL_STAT_MILE = "Statute_Mile_International"  ## Linear unit Statute_Mile_International 
  UL_INTL_STAT_MILE_CONV = "1609.344"  ## Linear unit Statute_Mile_Internationalconversion factor to meter 
  UL_INTL_FATHOM = "Fathom_International"  ## Linear unit Fathom_International 
  UL_INTL_FATHOM_CONV = "1.8288"  ## Linear unit Fathom_International conversion factor to meter 
  UL_INTL_CHAIN = "Chain_International"  ## Linear unit Chain_International 
  UL_INTL_CHAIN_CONV = "20.1168"  ## Linear unit Chain_International conversion factor to meter 
  UL_INTL_LINK = "Link_International"  ## Linear unit Link_International 
  UL_INTL_LINK_CONV = "0.201168"  ## Linear unit Link_International conversion factor to meter 
  UL_US_INCH = "Inch_US_Surveyor"  ## Linear unit Inch_US_Surveyor 
  UL_US_INCH_CONV = "0.025400050800101603"  ## Linear unit Inch_US_Surveyor conversion factor to meter 
  UL_US_YARD = "Yard_US_Surveyor"  ## Linear unit Yard_US_Surveyor 
  UL_US_YARD_CONV = "0.914401828803658"  ## Linear unit Yard_US_Surveyor conversion factor to meter 
  UL_US_CHAIN = "Chain_US_Surveyor"  ## Linear unit Chain_US_Surveyor 
  UL_US_CHAIN_CONV = "20.11684023368047"  ## Linear unit Chain_US_Surveyor conversion factor to meter 
  UL_US_STAT_MILE = "Statute_Mile_US_Surveyor"  ## Linear unit Statute_Mile_US_Surveyor 
  UL_US_STAT_MILE_CONV = "1609.347218694437"  ## Linear unit Statute_Mile_US_Surveyor conversion factor to meter 
  UL_INDIAN_YARD = "Yard_Indian"  ## Linear unit Yard_Indian 
  UL_INDIAN_YARD_CONV = "0.91439523"  ## Linear unit Yard_Indian conversion factor to meter 
  UL_INDIAN_FOOT = "Foot_Indian"  ## Linear unit Foot_Indian 
  UL_INDIAN_FOOT_CONV = "0.30479841"  ## Linear unit Foot_Indian conversion factor to meter 
  UL_INDIAN_CHAIN = "Chain_Indian"  ## Linear unit Chain_Indian 
  UL_INDIAN_CHAIN_CONV = "20.11669506"  ## Linear unit Chain_Indian conversion factor to meter 
  UA_DEGREE = "degree"  ## Angular unit degree 
  UA_DEGREE_CONV = "0.0174532925199433"  ## Angular unit degree conversion factor to radians 
  UA_RADIAN = "radian"  ## Angular unit radian 
  PM_GREENWICH = "Greenwich"  ## Prime meridian Greenwich 
  DN_NAD27 = "North_American_Datum_1927"  ## North_American_Datum_1927 datum name 
  DN_NAD83 = "North_American_Datum_1983"  ## North_American_Datum_1983 datum name 
  DN_WGS72 = "WGS_1972"  ## WGS_1972 datum name 
  DN_WGS84 = "WGS_1984"  ## WGS_1984 datum name 
  WGS84_SEMIMAJOR = 6378137.0  ## Semi-major axis of the WGS84 ellipsoid 
  WGS84_INVFLATTENING = 298.257223563  ## Inverse flattening of the WGS84 ellipsoid. 
  
proc registerAll*() {.cdecl, dynlib: libgdal, importc: "GDALAllRegister".}
  ## Register all known configured GDAL drivers.
  ## This function will drive any of the following that are configured into GDA:
  ## raster list http://gdal.org/formats_list.html, vector list http://gdal.org/ogr_formats.html
  ## This function should generally be called once at the beginning of the application.

proc open*(pszFilename: cstring, nOpenFlags: int32, papszAllowedDrivers: cstring, papszOpenOptions: cstring, papszSiblingFiles: cstring): Dataset {.cdecl, dynlib: libgdal, importc: "GDALOpenEx".}
  ## Open a raster or vector file as a Dataset.

proc getLayerByName*(hDS: Dataset, pszName: cstring): Layer {.cdecl, dynlib: libgdal, importc: "GDALDatasetGetLayerByName".}
  ## Fetch a layer by name.

proc getLayerCount*(hDS: Dataset): int32 {.cdecl, dynlib: libgdal, importc: "GDALDatasetGetLayerCount".}
  ## Get the number of layers in this dataset.

proc getLayer*(hDS: Dataset, iLayer: int32): Layer {.cdecl, dynlib: libgdal, importc: "GDALDatasetGetLayer".}
  ## Fetch a layer by index.

proc resetReading*(hLayer: Layer) {.cdecl, dynlib: libgdal, importc: "OGR_L_ResetReading".}
  ## Reset feature reading to start on the first feature.

proc getNextFeature*(hLayer: Layer): Feature {.cdecl, dynlib: libgdal, importc: "OGR_L_GetNextFeature".}
  ## Fetch the next available feature from this layer.

proc getLayerDefn*(hLayer: Layer): FeatureDefn {.cdecl, dynlib: libgdal, importc: "OGR_L_GetLayerDefn".}
  ## Fetch the schema information for this layer.
  
proc getFieldCount*(hDefn: FeatureDefn): int32 {.cdecl, dynlib: libgdal, importc: "OGR_FD_GetFieldCount".}
  ## Fetch number of fields on this feature.

proc getFieldDefn*(hDefn: FeatureDefn, iField: int32): FieldDefn {.cdecl, dynlib: libgdal, importc: "OGR_FD_GetFieldDefn".}
  ## Fetch field definition of the passed feature definition.

proc getFieldIndex*(hDefn: FeatureDefn, pszFieldName: cstring): int32 {.cdecl, dynlib: libgdal, importc: "OGR_FD_GetFieldIndex".}
  ## Find field by name.

proc getType*(hDefn: FieldDefn): FieldType {.cdecl, dynlib: libgdal, importc: "OGR_Fld_GetType".}
  ## Fetch type of this field.

proc getFieldAsInteger*(hFeat: Feature, iField: int32): int32 {.cdecl, dynlib: libgdal, importc: "OGR_F_GetFieldAsInteger".}
  ## Fetch field value as int32.

proc getFieldAsInteger64*(hFeat: Feature, iField: int32): int {.cdecl, dynlib: libgdal, importc: "OGR_F_GetFieldAsInteger64".}
  ## Fetch field value as int64.

proc getFieldAsString*(hFeat: Feature, iField: int32): cstring {.cdecl, dynlib: libgdal, importc: "OGR_F_GetFieldAsString".}
  ## Fetch field value as cstring.

proc getFieldAsDouble*(hFeat: Feature, iField: int32): float {.cdecl, dynlib: libgdal, importc: "OGR_F_GetFieldAsDouble".}
  ## Fetch field value as float32.

proc getGeometryRef*(hFeat: Feature): Geometry {.cdecl, dynlib: libgdal, importc: "OGR_F_GetGeometryRef".}
  ## Fetch an handle to feature geometry.

proc getGeometryRef*(hGeom: Geometry, iSubGeom: int32): Geometry {.cdecl, dynlib: libgdal, importc: "OGR_G_GetGeometryRef".}
  ## Fetch geometry from a geometry container.

proc getGeometryType*(hGeom: Geometry): GeometryType {.cdecl, dynlib: libgdal, importc: "OGR_G_GetGeometryType".}
  ## Fetch geometry type.

proc getX*(hGeom: Geometry, i: int32): float {.cdecl, dynlib: libgdal, importc: "OGR_G_GetX".}
  ## Fetch the x coordinate of a point from a geometry.

proc getY*(hGeom: Geometry, i: int32): float {.cdecl, dynlib: libgdal, importc: "OGR_G_GetY".}
  ## Fetch the y coordinate of a point from a geometry.

proc getZ*(hGeom: Geometry, i: int32): float {.cdecl, dynlib: libgdal, importc: "OGR_G_GetZ".}
  ## Fetch the z coordinate of a point from a geometry.

proc getGeomFieldCount*(hFeat: Feature): int32 {.cdecl, dynlib: libgdal, importc: "OGR_F_GetGeomFieldCount".}
  ## Fetch number of geometry fields on this feature.

proc getGeomFieldRef*(hFeat: Feature, iField: int32): Geometry {.cdecl, dynlib: libgdal, importc: "OGR_F_GetGeomFieldRef".}
  ## Fetch an handle to feature geometry.

proc destroy*(hFeat: Feature) {.cdecl, dynlib: libgdal, importc: "OGR_F_Destroy".}
  ## Destroy feature

proc close*(hDS: Dataset) {.cdecl, dynlib: libgdal, importc: "GDALClose".}
  ## Close GDAL dataset

proc flatten*(eType: GeometryType): GeometryType {.cdecl, dynlib: libgdal, importc: "OGR_GT_Flatten".}
  ## Returns the 2D geometry type corresponding to the passed geometry type.

proc getProjectionRef*(hDS: Dataset): cstring {.cdecl, dynlib: libgdal, importc: "GDALGetProjectionRef".}
  ## Fetch the projection definition string for this dataset.

proc getSpatialReference*(hGeom: Geometry): SpatialReference {.cdecl, dynlib: libgdal, importc: "OGR_G_GetSpatialReference".}
  ## Returns spatial reference system for geometry.

proc intersection*(hThis, hOther: Geometry): Geometry {.cdecl, dynlib: libgdal, importc: "OGR_G_Intersection".}
  ## Compute intersection.

proc intersects*(hThis, hOther: Geometry): int {.cdecl, dynlib: libgdal, importc: "OGR_G_Intersects".}
  ## Do the features intersect?

proc length*(hGeom: Geometry): float {.cdecl, dynlib: libgdal, importc: "OGR_G_Length".}
  ## Compute length of a geometry.

proc overlaps*(hThis, hOther: Geometry): int {.cdecl, dynlib: libgdal, importc: "OGR_G_Overlaps".}
  ## Test for overlap.

proc pointOnSurface*(hGeom: Geometry): Geometry {.cdecl, dynlib: libgdal, importc: "OGR_G_PointOnSurface".}
  ## Returns a point guaranteed to lie on the geometry.

proc touches*(hThis, hOther: Geometry): int32 {.cdecl, dynlib: libgdal, importc: "OGR_G_Touches".}
  ## Test for touching

proc value*(hGeom: Geometry, dfDistance: float): Geometry {.cdecl, dynlib: libgdal, importc: "OGR_G_Value".}
  ## Fetch point at given distance along curve.

proc getName*(hLayer: Layer): cstring {.cdecl, dynlib: libgdal, importc: "OGR_L_GetName".}
  ## Return the layer name

proc getSpatialRef*(hLayer: Layer): SpatialReference {.cdecl, dynlib: libgdal, importc: "OGR_L_GetSpatialRef".}
  ## Fetch the spatial reference system for this layer.

proc exportToProj4*(hSRS: SpatialReference, ppszReturn: cstring): int32 {.cdecl, dynlib: libgdal, importc: "OSRExportToProj4".}
  ## Export coordinate system in PROJ.4 format.

proc exportSRToWkt*(hSRS: SpatialReference, ppszReturn: cstringArray): int32 {.cdecl, dynlib: libgdal, importc: "OSRExportToWkt".}
  ## Convert this SRS into WKT format.

proc distance*(hFirst, hOther: Geometry): float {.cdecl, dynlib: libgdal, importc: "OGR_G_Distance".}
  ## Compute distance between two geometries.

proc distance3D*(hFirst, hOther: Geometry): float {.cdecl, dynlib: libgdal, importc: "OGR_G_Distance3D".}
  ## Returns 3D distance between two geometries.

proc createGeometry*(gType: GeometryType): Geometry {.cdecl, dynlib: libgdal, importc: "OGR_G_CreateGeometry".}
  ## Create an empty geometry of indicated type.

proc setPoint2D*(hGeom: Geometry, i: int32, dfX, dfY: float) {.cdecl, dynlib: libgdal, importc: "OGR_G_SetPoint_2D".}
  ## Set the location of a vertex in a point or linestring geometry. i is the index of the vertex to assign (zero based) or zero for a point.

proc setPoint*(hGeom: Geometry, i: int, dfX, dfY, dfZ: float) {.cdecl, dynlib: libgdal, importc: "OGR_G_SetPoint".}
  ## Set the location of a vertex in a point or linestring geometry.

proc getPointCount*(hGeom: Geometry): int32 {.cdecl, dynlib: libgdal, importc: "OGR_G_GetPointCount".}
  ## Fetch number of points from a geometry.

proc getPoint*(hGeom: Geometry, i: int32, pdfX, pdfY, pdfZ: var float) {.cdecl, dynlib: libgdal, importc: "OGR_G_GetPoint".}
  ## Fetch a point in line string or a point geometry.

proc forceToLineString*(hGeom: Geometry): Geometry {.cdecl, dynlib: libgdal, importc: "OGR_G_ForceToLineString".}
  ## Convert to line string.

proc setAttributeFilter*(hLayer: Layer, query: cstring): int32 {.cdecl, dynlib: libgdal, importc: "OGR_L_SetAttributeFilter".}
  ## Set a new attribute query.

proc getFeature*(hLayer: Layer, fId: int): Feature {.cdecl, dynlib: libgdal, importc: "OGR_L_GetFeature".}
  ## Fetch a feature by its identifier.

proc getFeatureCount*(hLayer: Layer, fId: int): int {.cdecl, dynlib: libgdal, importc: "OGR_L_GetFeatureCount".}
  ## Fetch the feature count in this layer.

proc importFromEPSG*(hSRS: SpatialReference, nCode: int32): int32 {.cdecl, dynlib: libgdal, importc: "OSRImportFromEPSG".}
  ## Initialize SRS based on EPSG GCS or PCS code.

proc newCoordinateTransformation*(sourceSRS, targetSRS: SpatialReference): CoordinateTransformation {.cdecl, dynlib: libgdal, importc: "OCTNewCoordinateTransformation".}
  ## Create transformation object

proc transform*(hGeom: Geometry, hTransform: CoordinateTransformation): int32 {.cdecl, dynlib: libgdal, importc: "OGR_G_Transform".}
  ## Apply arbitrary coordinate transformation to geometry.

proc transformTo*(hGeom: Geometry, hSRS: SpatialReference): int32 {.cdecl, dynlib: libgdal, importc: "OGR_G_TransformTo".}
  ## Transform geometry to new spatial reference system.

proc newSpatialReference*(pszWKT: cstring): SpatialReference {.cdecl, dynlib: libgdal, importc: "OSRNewSpatialReference".}
  ## Constructor

proc getGeometryCount*(hGeom: Geometry): int32 {.cdecl, dynlib: libgdal, importc: "OGR_G_GetGeometryCount".}
  ## Fetch the number of elements in a geometry or number of geometries in container.

proc clone*(hGeom: Geometry): Geometry {.cdecl, dynlib: libgdal, importc: "OGR_G_Clone".}
  ## Make a copy of this object.

proc getGeometryName(hGeom: Geometry): cstring {.cdecl, dynlib: libgdal, importc: "OGR_G_GetGeometryName".}
  ## Fetch WKT name for geometry type.

proc exportToWkt*(hGeom: Geometry, ppszSrcText: pointer): int32 {.cdecl, dynlib: libgdal, importc: "OGR_G_ExportToWkt".}
  ## Convert a geometry into well known text format.

# helper procs

iterator features*(layer: Layer): Feature =
  var res: Feature
  while true:
    res = layer.getNextFeature()
    if isNil(res):
      break
    yield res

proc getFieldType*(fdefn: FeatureDefn, i: int32): FieldType =
  var fd = fdefn.getFieldDefn(i)
  return fd.getType()

proc getStringField*(f: Feature, fdefn: FeatureDefn, field: string): cstring =
  var index = fdefn.getFieldIndex(cstring(field))
  return f.getFieldAsString(index)

proc point2d*(x,y: float): Geometry =
  ## Point constructor
  result = createGeometry(Point)
  result.setPoint2D(0, x, y)

proc wkt*(geom: Geometry): string =
  var
    dummy: array[1, string]
    wktA = dummy.allocCStringArray
  discard exportToWkt(geom, wktA)
  result = wktA.cstringArrayToSeq()[0]
  wktA.deallocCStringArray()

proc closestPointonLine*(ln, pt0: Geometry): Geometry =
  # TODO: FixMe
  var
    x, y, z: float
    D = 99999.9
    pt: Geometry
    d: float
    n = ln.forceToLineString.getPointCount()
  echo "n: ", n  
  for i in 0 .. <n:
    ln.getPoint(i, x, y, z) 
    pt = createGeometry(Point)
    pt.setPoint(0, x, y, z)
    d = distance(pt0, pt)
    echo d
    if d > D:
      D = d
      result = pt
  echo D
      
# proc getField(f: Feature, fdefn: FeatureDefn, field: string): auto =
#   var index = fdefn.getFieldIndex(cstring(field))
#   case fdefn.getFieldType(index):
#     of Integer: return f.getFieldAsInteger(index)
#     of Integer64: return f.getFieldAsInteger64(index)
#     of Real: return f.getFieldAsDouble(index)
#     of String: return f.getFieldAsString(index)
#     else: return f.getFieldAsString(index)

