$("document").ready(function(){

  OAuth.initialize('xiZX0elRQVlTTgqTlZ-XOBn-19k');
  
  $('.twitter').click(function() {

    OAuth.popup('twitter')
      .done(function(result) {
        //use result.access_token in your API request 
        //or use result.get|post|put|del|patch|me methods (see below)
        // debugger;
        // result.get('/me')
        // .done(function (response) {
        //     //this will display "John Doe" in the console
        //     debugger;
        //     console.log(response.name);
        // })
        // .fail(function (err) {
        //     //handle error with err
        // });

        result.get('/1.1/account/verify_credentials.json').done(function(data) {
           console.log(data)
           // alert('Hello ' + data.name)
           args = {
              name: data.name,
              provider: 'twitter',
              uid: data.id
           }

           // authenticate with the server
           $.post('/auth/sign_in', args , function(data) {
              // do something
           });
        });
      })
      .fail(function (err) {
        //handle error with err
        // debugger;
      });    
  });  
});