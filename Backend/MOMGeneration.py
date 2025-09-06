import whisper
from google import genai
import io
import tempfile

apiFile=open("apiKey.txt")
API_KEY=apiFile.read()
client =genai.Client(api_key=API_KEY)

def generateTranscription(audioPath):
    model = whisper.load_model("tiny")
    audio = whisper.load_audio(audioPath)
    result = model.transcribe(audioPath)
    return result["text"]

def generateMOM(audio):
    file_path = f"/{audio.filename}"
    with tempfile.NamedTemporaryFile(delete=False, suffix=".mp3") as tmp:
        audio.save(tmp.name)
        file_path = tmp.name
    transcript=generateTranscription(file_path) 
    try:
        response=client.models.generate_content(
            model="gemini-2.5-flash",
            contents=f"""
        You are an expert at creating meeting minutes from a transcription.
        Your task is to review the following transcription and provide a clear, concise, and well-structured summary.
        The minutes should include:
        - A brief, overall summary of the meeting.
        - A bulleted list of key discussion points.
        - A bulleted list of all action items, including who is responsible and any deadlines mentioned.
        - A bulleted list of any decisions made.
        
        Transcription:
        {transcript}
            """  
        )
        return response.text
    except Exception as e:
        return f"Gemini API Error: {e}"
