from flask import Flask, request, render_template, jsonify
from transcriber import transcribe

app = Flask(__name__)

@app.route("/", methods=['POST', 'GET'])
def index():
    if request.method == "POST":
        f = request.files['audio_data']
        with open('audio.wav', 'wb') as audio:
            f.save(audio)
        print('file uploaded successfully')

        return render_template('index.html', request='POST')
    else:
        return render_template('index.html')

@app.route("/ask", methods=['GET'])
def ask():
    query = transcribe()
    return jsonify(query)

if __name__ == "__main__":
    app.run()