
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
  Template.docCollection.rendered  = ->
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

      window[Session.get('collUsed')].find().fetch()

  Template.docCollection.events
    'click .lib-item':(e)->
      window.open this.url() , "_blank"

  Template.docCollection.helpers
    platformFiles:()->

      window[Session.get('collUsed')].find().fetch()
    getFileIcon:(fid)->
      switch window[Session.get('collUsed')].findOne(fid).original.type
        when 'application/zip' then return "/assets/dashboardimages/pdf-icon.png"
        when 'image/png' then return "/assets/dashboardimages/pdf-icon.png"
        when "application/vnd.openxmlformats-officedocument.presentationml.presentation" then return "/assets/dashboardimages/pdf-icon.png"
        when "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" then return "/assets/dashboardimages/pdf-icon.png"
        when "application/pdf" then return "/assets/dashboardimages/pdf-icon.png"

#


  Template.uploadFileBtn.events
    'click .upload-file':(e)->
      $('.modal').modal()

#      $('#new-user-files').trigger('click')



    'click  .create-new-file':(e)->
      $("#overlay").show()
      Session.set("docLeft",document.getElementById('new-user-files').files.length)
      for f in document.getElementById('new-user-files').files
        plfile = new FS.File(f)
        plfile.platform = platforms.findOne()._id
        plfile.owner = Meteor.userId()
        plfile.description = $("#fileDesc").val()
        x = window[Session.get('collUsed')].insert(plfile)
        x.on("uploaded",()->
          nowLeft = parseInt(Session.get("docLeft")) - 1
          Session.set("docLeft",nowLeft)
          $('.modal').modal('hide')

        )


        Tracker.autorun(()->
          if Session.get("docLeft") is 0
            $("#overlay").hide()
        )


    'click .file-delete-btn':(e)->
       window[Session.get('collUsed')].remove({_id:this._id})