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
  region: 'ap-southeast-1'
  accessKeyId: '***'
  secretAccessKey: '****'
  bucket: '***'
  ACL: 'private'
  folder:"***"

  maxTries: 1)



@s3Files = new FS.Collection("s3Files", {
  stores: [s3Store]
});

