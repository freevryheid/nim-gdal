import gdal

proc main() =
  var
    hDS: Dataset
    hLayer: Layer
    hFeature: Feature
  AllRegister()
  hDS = Open("routes.geojson", OF_VECTOR, nil, nil, nil)
  if isNil(hDS):
    quit("Open failed")
  hLayer = getLayer(hDS, 0)
  resetReading(hLayer)
  while true:
    hFeature = getNextFeature(hLayer)
    if isNil(hFeature):
      break
    var
      hFDefn: FeatureDefn
      iField: int
      hGeometry: Geometry
    hFDefn = getLayerDefn(hLayer)
    for iField in 0 .. < getFieldCount(hFDefn):
      var hFieldDefn: FieldDefn = getFieldDefn(hFDefn, iField)
      case getType(hFieldDefn):
        of Integer: echo getFieldAsInteger(hFeature, iField)
        of Integer64: echo getFieldAsInteger64(hFeature, iField)
        of Real: echo getFieldAsDouble(hFeature, iField)         
        of String: echo getFieldAsString(hFeature, iField)
        else: echo getFieldAsString(hFeature, iField)
      var hGeometry = getGeometryRef(hFeature)
      if not isNil(hGeometry):
        if flatten(getGeometryType(hGeometry)) == Point:
          echo getX(hGeometry, 0), getY(hGeometry, 0)
        else:
          echo "no point geometry"
    Destroy(hFeature)
  Close(hDS)

main()
