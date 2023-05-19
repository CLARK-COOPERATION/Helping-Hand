# Helping Hand a Mental health application

Our mental health app is designed for college students in India, featuring mood tracking, journaling, and progress updates, all encrypted with AES. AI chatbot Baymax offers personalized assistance, while mental health counselors and curated music aid relaxation. The app offers customizable profiles and prioritizes data privacy and personalization for a comprehensive resource.

## Using the application

the website is available on this [link](http://104.154.205.59/) if its not working you can copy paste this url in your favourite browser http://104.154.205.59/ you can even find the link in this repository description.

**Note: Use http and not https**  
It is prefered to run the webapplication in desktop, and if you want to run it in the mobile application you can download the apk file from this apk file stored in google drive [apk](https://drive.google.com/file/d/1LySTKVGbOSAdgg2a7NLRHWnpb8DeJPxI/view?usp=sharing) or the link is https://drive.google.com/file/d/1LySTKVGbOSAdgg2a7NLRHWnpb8DeJPxI/view?usp=sharing

## Login info
Email: kambojiakhilesh@gmail.com  
password: 12052002 

## Features

- Journal
- Baymax (chat bot)
- Mood monitoring
- Daily routine monitoring
- Professional counselors
- personalized Profile
- Music

lets have a quick look into each of these now

## Onboarding Pages

Upon opening the mental health application, users are greeted with a visually pleasing splash screen followed by three onboarding pages highlighting the app's best features. These pages aim to introduce users to the app's functionalities in an engaging manner, ensuring that they understand how to navigate and utilize the app's various tools.

<p float="left">
<img src = "https://user-images.githubusercontent.com/93464909/232287272-4ccbccfc-5c1f-4ae0-a150-6c30ad18e4b5.png" width="225" height="400"/>
<img src = "https://user-images.githubusercontent.com/93464909/232287180-de9210ab-c479-41fa-bbc6-8104fa7d9644.png" width="225" height="400"/>
<img src = "https://user-images.githubusercontent.com/93464909/232287287-6d54dde5-5bba-41ed-acf5-5152f047426d.png" width="225" height="400"/>
<img src = "https://user-images.githubusercontent.com/93464909/232287296-c3de5969-33bf-47e6-a806-c3a1fbfc450a.png" width="225" height="400"/>
</p>

## Login Page

The login page of our mental health app utilizes Firebase's authentication system for user login, requiring them to enter their email and password. Test data provided above can be used for easy testing purposes.

<img src = "https://user-images.githubusercontent.com/93464909/232287381-1acc5337-fdb4-40c4-afd1-9157ed31f74c.png" width="225" height="400"/>


## Home Page

The home page has two main functions. It allows users to manage mood swings, and the "feelings" tab enables users to track the reasons behind their mood swings.

User data privacy is a top priority in this application. To ensure data security, we use AES encryption, which means that only the user can read their data.

<img src = "https://user-images.githubusercontent.com/93464909/232287459-bb0d5d3a-9728-43dd-b18e-e21393e1c83b.png" width="225" height="400"/>

## Activity Page

The mental health of a user can be tracked by two major factors: their food and sleep routine. This data is displayed again in the Progress Page, where users can view their progress. To help track this information, we have a short quiz for users to input how long they slept the previous day and how much food they ate. Once completed, we provide users with meditation tips to help them maintain their inner self.

<p float="left">
<img src = "https://user-images.githubusercontent.com/93464909/232287450-4672f805-c9d6-41ec-9c72-368f339bb263.png" width="225" height="400"/>
<img src = "https://user-images.githubusercontent.com/93464909/232287375-700c582e-004a-4ef3-b2e4-230a302b0214.png" width="225" height="400"/>
</p>

## Progress Page

The progress page in our mental health app displays the user's past mood, sleep, and food routine entries for self-monitoring. It provides users with the necessary information to make informed decisions about their mental health, including the ability to connect with a relevant counselor or take personal action.

<img src = "https://user-images.githubusercontent.com/93464909/232287363-a6c84f18-d560-4e19-8371-dccc5eb09f29.png" width="225" height="400"/>

## Counselor Page

The "Counselor Page" on our mental health app displays a list of highly professional counselors available in the college, allowing users to connect with anyone they feel comfortable with. When the user clicks on "Connect," an email is sent to the selected counselor, who will then contact the user to schedule a session. This feature provides users with easy access to qualified mental health professionals who can offer support and guidance during challenging times.

<p float="left">
<img src = "https://user-images.githubusercontent.com/93464909/232287437-7da654ca-777a-495b-80fb-26fd534d9d76.png" width="225" height="400"/>
<img src = "https://user-images.githubusercontent.com/93464909/232287411-30b42dc2-45ee-4daa-a49a-f4887f63e67e.png" width="225" height="400"/>
</p>

## Profile page

The profile page displays basic information of the user, including the option to choose an avatar from default images or from the user's camera or gallery. The FAQ section is also available for the user's convenience.

<img src = "https://user-images.githubusercontent.com/93464909/232287356-55ac2ce9-c873-4845-ba2f-3d0231eefba5.png" width="225" height="400"/>

## Journal Pages

Our mental health app includes a journal feature that allows users to privately and securely reflect on their thoughts, emotions, and experiences. With our app, users can maintain a personal diary where they can record their innermost feelings in a confidential manner. We recognize the importance of privacy and security, especially when it comes to sensitive topics like mental health. Therefore, we have implemented strong measures to protect user data by encrypting it with the AES algorithm and storing it in a secure Firebase database. You can trust that our app is committed to keeping your personal information safe and secure.

<p float="left">
<img src = "https://user-images.githubusercontent.com/93464909/232287349-bbc59ac1-82cd-47d6-9343-05bf25c245b2.png" width="225" height="400"/>
<img src = "https://user-images.githubusercontent.com/93464909/232287523-6bab546a-d877-42e7-b711-003bb10226ac.png" width="225" height="400"/>
<img src = "https://user-images.githubusercontent.com/93464909/232287393-cb80223d-b2bb-468a-9416-4ec1910f3db2.png" width="225" height="400"/>
</p>

## Baymax (AI chat bot)

We've integrated Baymax, an AI chatbot, into our mental health app to assist users on their journey. Baymax utilizes cutting-edge technology, created using Google Dialogflow, a machine learning tool for conversational interfaces. Our app also incorporates the Google Cloud API to enhance Baymax's natural language processing capabilities, enabling it to provide personalized and relevant responses to user queries. With Baymax, our users can benefit from a supportive and intelligent tool that can help them manage their mental health effectively.

<img src = "https://user-images.githubusercontent.com/93464909/232287339-e0138c4a-1940-4ec6-8ec7-b47acbd41533.png" width="225" height="400"/>


## Music page

This is a curated list of music recommended by professionals to help ease the mind, promote relaxation, and improve mental health, particularly during tough times. These selections have been chosen for their ability to create a peaceful and calming atmosphere.

<img src = "https://user-images.githubusercontent.com/93464909/232287324-8c30f366-45ac-4a80-86b6-42a1b85c580b.png" width="225" height="400"/>

## Feedback

Any updations can be done through your valuable feedback you can mail us your feedback on this mail clark134080@gmail.com
