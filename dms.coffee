if Meteor.isServer
  @initDMS = (mode,options)->
    setMode(mode)


  @setMode = (mode)->
    @dmsMode = mode
  @getMode = ()->
    dmsMode

  Meteor.publish('systemFiles',(uid)->
    this.ready()

#    pid = platforms.findOne({tenantName: pname})._id
    systemFiles.find({owner:uid})
  )
  Meteor.publish('gridFiles',(uid)->
    this.ready()

    #    pid = platforms.findOne({tenantName: pname})._id
    gridFiles.find({owner:uid})
  )
  Meteor.publish('s3Files',(uid)->
    this.ready()

    #    pid = platforms.findOne({tenantName: pname})._id
    s3Files.find({owner:uid})
  )

  Meteor.methods
      getDmsMode:()->
        getMode()