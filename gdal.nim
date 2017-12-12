when defined(windows):
  const libgdal = "libgdal.dll"
elif defined(macosx):
  const libgdal = "libgdal.dylib"
else:
  const libgdal = "libgdal.so"

type
  Dataset* = pointer
  Layer* = pointer
  Feature* = pointer
  FeatureDefn* = pointer
  FieldDefn* = pointer
  Geometry* = pointer
  SpatialReference* = pointer
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
  OF_VECTOR* = 0x04

proc AllRegister*() {.cdecl, dynlib: libgdal, importc: "GDALAllRegister".}
  ## Register all known configured GDAL drivers.
  ## This function will drive any of the following that are configured into GDA:
  ## raster list http://gdal.org/formats_list.html, vector list http://gdal.org/ogr_formats.html
  ## This function should generally be called once at the beginning of the application.

proc Open*(pszFilename: cstring, nOpenFlags: int32, papszAllowedDrivers: cstring, papszOpenOptions: cstring, papszSiblingFiles: cstring): Dataset {.cdecl, dynlib: libgdal, importc: "GDALOpenEx".}
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

proc getFieldDefn*(hDefn: FeatureDefn, iField: int): FieldDefn {.cdecl, dynlib: libgdal, importc: "OGR_FD_GetFieldDefn".}
  ## Fetch field definition of the passed feature definition.

proc getType*(hDefn: FieldDefn): FieldType {.cdecl, dynlib: libgdal, importc: "OGR_Fld_GetType".}
  ## Fetch type of this field.

proc getFieldAsInteger*(hFeat: Feature, iField: int32): int32 {.cdecl, dynlib: libgdal, importc: "OGR_F_GetFieldAsInteger".}
  ## Fetch field value as int32.

proc getFieldAsInteger64*(hFeat: Feature, iField: int32): int {.cdecl, dynlib: libgdal, importc: "OGR_F_GetFieldAsInteger64".}
  ## Fetch field value as int64.

proc getFieldAsString*(hFeat: Feature, iField: int32): cstring {.cdecl, dynlib: libgdal, importc: "OGR_F_GetFieldAsString".}
  ## Fetch field value as cstring.

proc getFieldAsDouble*(hFeat: Feature, iField: int32): float32 {.cdecl, dynlib: libgdal, importc: "OGR_F_GetFieldAsDouble".}
  ## Fetch field value as float32.

proc getGeometryRef*(hFeat: Feature): Geometry {.cdecl, dynlib: libgdal, importc: "OGR_F_GetGeometryRef".}
  ## Fetch an handle to feature geometry.

proc getGeometryRef*(hGeom: Geometry, iSubGeom: int32): Geometry {.cdecl, dynlib: libgdal, importc: "OGR_G_GetGeometryRef".}
  ## Fetch geometry from a geometry container.

proc getGeometryType*(hGeom: Geometry): GeometryType {.cdecl, dynlib: libgdal, importc: "OGR_G_GetGeometryType".}
  ## Fetch geometry type.

proc getX*(hGeom: Geometry, i: int32): float32 {.cdecl, dynlib: libgdal, importc: "OGR_G_GetX".}
  ## Fetch the x coordinate of a point from a geometry.

proc getY*(hGeom: Geometry, i: int32): float32 {.cdecl, dynlib: libgdal, importc: "OGR_G_GetY".}
  ## Fetch the y coordinate of a point from a geometry.

proc getZ*(hGeom: Geometry, i: int32): float32 {.cdecl, dynlib: libgdal, importc: "OGR_G_GetZ".}
  ## Fetch the z coordinate of a point from a geometry.

proc getGeomFieldCount*(hFeat: Feature): int32 {.cdecl, dynlib: libgdal, importc: "OGR_F_GetGeomFieldCount".}
  ## Fetch number of geometry fields on this feature.

proc getGeomFieldRef*(hFeat: Feature, iField: int32): Geometry {.cdecl, dynlib: libgdal, importc: "OGR_F_GetGeomFieldRef".}
  ## Fetch an handle to feature geometry.

proc Destroy*(hFeat: Feature) {.cdecl, dynlib: libgdal, importc: "OGR_F_Destroy".}
  ## Destroy feature

proc Close*(hDS: Dataset) {.cdecl, dynlib: libgdal, importc: "GDALClose".}
  ## Close GDAL dataset

proc Flatten*(eType: GeometryType): GeometryType {.cdecl, dynlib: libgdal, importc: "OGR_GT_Flatten".}
  ## Returns the 2D geometry type corresponding to the passed geometry type.

proc getProjectionRef*(hDS: Dataset): cstring {.cdecl, dynlib: libgdal, importc: "GDALGetProjectionRef".}
  ## Fetch the projection definition string for this dataset.

proc getSpatialReference(hGeom: Geometry): SpatialReference {.cdecl, dynlib: libgdal, importc: "OGR_G_GetSpatialReference".}
  ## Returns spatial reference system for geometry.

proc Intersection(hThis, hOther: Geometry): Geometry {.cdecl, dynlib: libgdal, importc: "OGR_G_Intersection".}
  ## Compute intersection.

proc Intersects(hThis, hOther: Geometry): int32 {.cdecl, dynlib: libgdal, importc: "OGR_G_Intersects".}
  ## Do the features intersect?

proc Length(hGeom: Geometry): float {.cdecl, dynlib: libgdal, importc: "OGR_G_Length".}
  ## Compute length of a geometry.



