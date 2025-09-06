# MOM Generator App

Its an App which generates Minutes Of Meeting out of audio and video uploaded by the user. The audio files are uploaded to the backend which first generates transcription using local model of Whisper and then makes an API call to Gemini LLM to generate Minutes Of Meeting from the transcription.After generating MOM the backends sends it to the app and the MOM is displayed on the screen.

# Requirements to run the source code

## Backend Setup
In the backend folder open the terminal and write the following command to create virtual environment:
```
python -m venv venv
```
To activate the virtual environment use this command:
```
.\venv\Scripts\activate
```
Now after activating the virtual environment install all the required libraries from requirements.txt:
```
pip install -r requirements.txt
```
And the final step is to run the backend server on your local device:
```
flask --app main run --host=0.0.0.0
```
**Note:  Generate your own api key from google AI studio and paste the api key in txt file "apiKey.txt" in the backend folder**

Also download the FFmpeg  binary on your system and add its **\bin** folder to your system's PATH .

## Flutter Setup
[Follow the official docs to setup Flutter on your PC.](https://docs.flutter.dev/get-started/install/windows/mobile)
Also make sure to  add your ip address  in OverlayWidgets.dart in the the argument of generateTranscription() .

**Don't touch backend files, all the issues are for frontend.**




