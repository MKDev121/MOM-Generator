from flask import Flask,request,jsonify
import MOMGeneration as momGen

app = Flask(__name__)
app.config['MAX_CONTENT_LENGTH'] = 50 * 1024 * 1024
@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

@app.route("/generate",methods=['POST'])
def generate():
    if 'audio' not in request.files:
        return jsonify({'error': 'No file part in the request'}), 400
    audio_file=request.files['audio']
    if audio_file.filename == '':
        return jsonify({'error': 'No selected file'}), 400
    
    if audio_file:

        mom=momGen.generateMOM(audio_file)
        return jsonify({'mom':mom}),200

if __name__=="__main__":
    app.run(debug=True,host="0.0.0.0",port=5000)