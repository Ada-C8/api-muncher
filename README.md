# Recipe API Consumer

## Summary 
I built this web application as a class assignment at Ada Developers Academy. This was our first assignment where we consumemed an API in a web application. This web application allows a user to search for recipies that contain a specific search term. For this assignment I also learned how to use the VCR gem to decrease the number of API calls made in my tests. The VCR gem captures the results of a real API call in your tests, saves the response to a file, and the next time the tests run it replays this API call instead of making a new API call. 

Checkout the [live site](https://api-muncher-tv.herokuapp.com) or [video demo](https://drive.google.com/file/d/1HYvu5nlgCaM3EHfu2JKSoJIAdhsTrMk9/view?usp=sharing) of api-muncher! 
  
## Assignment specifications 
### Purpose
Create a web application that will display recipes based on a search term. We will utilize an API from Edamam called the [Recipe Search API](https://developer.edamam.com/edamam-recipe-api).

This is an individual, [stage 2](https://github.com/Ada-Developers-Academy/pedagogy/blob/master/rule-of-three.md) project.

### Learning Goals:
- Configure an API for consumption
- Create authenticated API requests using HTTParty
- Consume JSON responses from an API
- Map response to application-specific data
- Separate API logic from application logic


#### Baseline
Before you start writing _any_ code:

- Explore the API documentation to become familiar with the request(s) you can make
- Create a Trello Board listing the features you will need to add and use it to track the progress of your app.

Once you've explored the API docs, this project:

- requires you to create a Rails application
  - conform to Rails conventions on naming and inflection
  - by using `rails new .` you will create a new rails app _inside_ of the fork folder instead of creating a _new_ folder for your rails app
- Use better_errors for debugging purposes
- Deploy your completed app to Heroku


#### Detailed Requirements  
**Search**:  
- The user shall type in a search term that will:
  - Make a request to the API using the search term
  - Display the results in a list to the user

**List View**:  
- This shall show a **paged** list of recipes for a given search term, _ten at a time_
- This view shall show the name of the recipe and the corresponding photo
- The view shall have a link from the recipe to a recipe show view

**Show View**:  
- This shall show the details about a given recipe. These details include:
  - Name
  - Link to the original recipe (opens in a new tab)
  - Ingredients
  - Dietary information

**Additional Requirements**:  
- One of the things that permits us to use this API, it providing attribution to the API's created. We must provide this somewhere on our site. Example locations include the footer or an about page.
  - [Examples from the API site](https://www.dropbox.com/sh/ss34tnh4kyfxkxu/AADNJ_pB7Ou8_MVrYxgM4aQYa?dl=0&preview=Attribution+examples.pdf)
- You must also create tests for your API Wrapper & any classes as well as controller tests using VCR
- Your site must have a **responsive** look and feel, use semantic HTML as well as any grid formatting using Zurb Foundation

#### Important Notes:
- Using this API as a developer limits the number of API calls in a month to 5000. This means that we must try to minimize API calls for testing purposes as much as possible, to ensure you do not exceed this number of API calls in the one week of development we have.


#### Optionals:
- Keep track of most recent search terms and allow user's to return to those searches
- Implement an OAuth strategy using Google
  - Allow users to save recipes to a "favorites" section that they can return to
-  Provide checkboxes or other controls to limit the search to options such as:
	-  Peanut Free
	-  Soy Free
	-  High Protien
	-  Etc


#### Wireframes:
You have creative control over the design and layout of this project. Below are optional wireframes you may use. It is not a requirement that you do.

**Homepage:**

  ![Splash Page Wireframe](assets/Muncher_splash_wireframe.png )

  **Results Page:**

  ![Results Page Wireframe](assets/muncher_results_wireframe.png )

  **Recipe Show Page:**

  ![Results Page Wireframe](assets/muncher_recipe_wireframe.png )


Reminder: Make sure all content is still easy to read when the width of a screen is shrunk. Use flexible measurements like width and REM.

These should be responsive. When the screen width shrinks to a medium screen, have a row with only two recipes. On a small screen width, have only a single recipe per line.  
