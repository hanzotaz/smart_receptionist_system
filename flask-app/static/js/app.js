URL = window.URL || window.webkitURL;

var gumStream;                      //stream from getUserMedia()
var rec;                            //Recorder.js object
var input;                          //MediaStreamAudioSourceNode we'll be recording

var AudioContext = window.AudioContext || window.webkitAudioContext;
var audioContext //audio context to help us record

var toggleButton = document.getElementById("speak");
var toggled = false;

toggleButton.addEventListener("click", function() {
    if(!toggled) startRecording();
    else stopRecording();
})

function startRecording() {
    console.log("recordButton clicked");

    var constraints = { audio: true, video:false }

    navigator.mediaDevices.getUserMedia(constraints).then(function(stream) {
        console.log("getUserMedia() success, stream created, initializing Recorder.js ...");

        audioContext = new AudioContext();
        gumStream = stream;
        input = audioContext.createMediaStreamSource(stream);

        rec = new Recorder(input,{numChannels:1})
        rec.record()

        console.log("Recording started");
        toggled = true;

        document.getElementById("icon").classList.remove("fa-microphone");
        document.getElementById("icon").classList.add("fa-stop");

    })
}

function stopRecording() {
    console.log("stopButton clicked");
    toggled = false;

    document.getElementById("icon").classList.remove("fa-stop");
    document.getElementById("icon").classList.add("fa-microphone");

    rec.stop();
    gumStream.getAudioTracks()[0].stop();

    //create the wav blob and pass it on to uploadWAV
    rec.exportWAV(uploadWAV);
}

function uploadWAV(blob) {
    var filename = new Date().toISOString();

    var fd=new FormData();
    fd.append("audio_data",blob, filename);

    var xhr=new XMLHttpRequest();
    xhr.open("POST","/",true);
    xhr.send(fd);

    transcribe();
}

function transcribe() {
    fetch('/ask')
        .then((response) => response.json())
        .then(function (text) {
                var q = text.result;
                document.getElementById("query").innerHTML = "\"" + q + "\"";
                sendQuery(q)
        });
}

function sendQuery(q){
    request ='http://localhost:80/query?q='+ encodeURI(q);
    console.log('url: ' + request);
    fetch(request, {
        method: 'GET',
        headers: {
            "Access-Control-Allow-Origin": "*",
        }
    })
        .then((response) => response.json())
        .then((data) => document.getElementById("answer").innerHTML = data)
}