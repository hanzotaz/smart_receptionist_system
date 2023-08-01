# Smart Receptionist System with Voice Assistant and Indoor Positioning System

This is the Final Year Project for my Computer Engineering degree which uses Natural Language Processing (NLP) for Question Answering and Indoor Positioning for building navigation. All of this is to assist companies with handling guests similar to that of a traditional receptionist.

## How it Works

![system_architecture](img/architecture.png)

This system uses the browser as the main interface for the user where they can use voice input(speech-to-text using WhisperAI) to ask question and the HaystackAI(the NLP framework) will output appropriate answer. For the Indoor Navigation, a seperate app was built using Flutter and the waypoint is made using Estimote which connected with the user's phone using bluetooth. This will pinpoint the current location of the user and an algorithm based on the A* algorithm used to determined which path is the best for the user to get to their intended location.