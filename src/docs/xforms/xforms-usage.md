The purpose of using XForms in the Blumenbach application is to facilitate the creation of **new** TEI

The workflow for this process is as follows:

1. Create a New entry through the Form Runner interface (e.g. for a [new Brief](/apps/blumenbach/redirect-orbeon.xml?page=blumenbach/brief/new))
1. Administer the form entered data through the "Transform Form Data" Interface in the Blumenbach application.
    * Note: in order to access administration screens, the user must be logged in.
![Transform Interface](/apps/blumenbach/resources/images/docs/transform-screen.png)
1. By clicking the `transform` action, the XForm data will be transformed to TEI and then **TEI** column will indicate the entry as "true"
1. Once the XForm data has been transformed to TEI, the `transform` action will become disabled.  
1. If the `edit` action is clicked before the transformation, the Orbeon forms editor will be opened, if after, then the TEI will be opened in eXide.
1. The transformed TEI is now _staged_ in the `/data/publish` collection.  
1. If the file is not complete, then it can be deleted from the collection with eXide, reedited from the XForm, and the transformation done again.  
1. Once the file has been successfully reviewed, the next step is to `publish` the TEI into the data collection using the "Publish XForm TEI" interface:
 ![Publish Interface](/apps/blumenbach/resources/images/docs/publish-screen.png)
1. This will then copy the new TEI into the appropriate collection so that it can be viewed in a [Data View](../xquery/views)


