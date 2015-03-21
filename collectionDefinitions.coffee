
gridStore = new FS.Store.GridFS("gridFiles",
   chunkSize: 1024 * 1024*5 # optional, default GridFS chunk size in bytes (can be overridden per file).
)
@gridFiles = new FS.Collection("gridFiles",
  stores:[gridStore]

)

@systemFiles = new FS.Collection("systemFiles",

  stores: [

    new FS.Store.FileSystem("systemFiles",{path:"/var/www/systemFiles"})

  ]
)

s3Store = new (FS.Store.S3)('s3Files',
  region: 'my-s3-region'
  accessKeyId: 'account or IAM key'
  secretAccessKey: 'account or IAM secret'
  bucket: 'mybucket'
  ACL: 'myValue'
  folder: 'folder/in/bucket'
#  transformWrite: myTransformWriteFunction
#  transformRead: myTransformReadFunction
  maxTries: 1)

@s3Files = new FS.Collection("s3Files", {
  stores: [s3Store]
});