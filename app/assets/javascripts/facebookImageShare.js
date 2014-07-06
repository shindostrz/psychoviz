if ( XMLHttpRequest.prototype.sendAsBinary === undefined ) {
    XMLHttpRequest.prototype.sendAsBinary = function(string) {
        var bytes = Array.prototype.map.call(string, function(c) {
            return c.charCodeAt(0) & 0xff;
        });
        this.send(new Uint8Array(bytes));
    };
}

function postImageToFacebook( authToken, filename, mimeType, imageData, message )
{
    // this is the multipart/form-data boundary we'll use
    var boundary = '----ThisIsTheBoundary1234567890';
    // let's encode our image file, which is contained in the var
    var formData = '--' + boundary + '\r\n';
    formData += 'Content-Disposition: form-data; name="source"; filename="' + filename + '"\r\n';
    formData += 'Content-Type: ' + mimeType + '\r\n\r\n';
    for ( var i = 0; i < imageData.length; ++i )
    {
        formData += String.fromCharCode( imageData[ i ] & 0xff );
    }
    formData += '\r\n';
    formData += '--' + boundary + '\r\n';
    formData += 'Content-Disposition: form-data; name="message"\r\n\r\n';
    formData += message + '\r\n';
    formData += '--' + boundary + '--\r\n';

    var xhr = new XMLHttpRequest();
    xhr.open( 'POST', 'https://graph.facebook.com/me/photos?access_token=' + authToken, true );
    xhr.responseType = "json";
    xhr.onload = xhr.onerror = function() {
        console.log( xhr.response );
        window.xhrResponse = xhr.response;
        if (Friend.currentFriend && $("input:checkbox:checked").val()=="on") {
            tagFriendOnPost(xhr.response["id"]);
        }
    };
    xhr.setRequestHeader( "Content-Type", "multipart/form-data; boundary=" + boundary );
    xhr.sendAsBinary( formData );
}

function postCanvasToFacebook(message) {
    var canvas = document.getElementById("hiddenCanvas");
    var data = canvas.toDataURL("image/png");
    var encodedPng = data.substring(data.indexOf(',') + 1, data.length);
    var decodedPng = Base64Binary.decode(encodedPng);
    FB.login(function(response) {
        postImageToFacebook(response.authResponse.accessToken, "psychvizchart", "image/png", decodedPng, message);
    }, {scope: "publish_actions"});

}

function tagFriendOnPost(postId) {
    var friendId = Friend.currentFriend.uid;
    FB.api(
        "/"+postId+"/tags",
        "POST",
        {
            "tags": "[{'tag_uid': '"+friendId+"'}]"
        },
        function (response) {
          // if (response && !response.error) {
            console.log(response);
          // }
        }
    );
}