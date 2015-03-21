
if Meteor.isClient
  setCollToBeUsed = (clname)->
    Session.set('collUsed',clname)

  Template.documentList.rendered  = ->
    Meteor.call("getDmsMode",(err,res)->
      console.log res
      if res is 1
        Meteor.subscribe('gridFiles',Meteor.userId())
        setCollToBeUsed('gridFiles')

      if res is 2
        Meteor.subscribe('systemFiles',Meteor.userId())
        setCollToBeUsed('systemFiles')
      if res is 3
        Meteor.subscribe('s3Files',Meteor.userId())
        setCollToBeUsed('s3Files')


      console.log err
    )

  Template.documentList.helpers
    platformFiles:()->
      console.log s3Options?
      console.log Session.get('collUsed')
      window[Session.get('collUsed')].find().fetch()



  Template.uploadFileBtn.events
    'click .upload-file':(e)->
      $('#new-user-files').trigger('click')
    'change  #new-user-files':(e)->
      $("#overlay").show()
      Session.set("docLeft",document.getElementById('new-user-files').files.length)
      for f in document.getElementById('new-user-files').files
        plfile = new FS.File(f)
        plfile.platform = platforms.findOne()._id
        plfile.owner = Meteor.userId()
        x = window[Session.get('collUsed')].insert(plfile)
        x.on("uploaded",()->
          nowLeft = parseInt(Session.get("docLeft")) - 1
          Session.set("docLeft",nowLeft)

        )


        Tracker.autorun(()->
          if Session.get("docLeft") is 0
            $("#overlay").hide()
        )


    'click .file-delete-btn':(e)->
      systemFiles.remove({_id:this._id})