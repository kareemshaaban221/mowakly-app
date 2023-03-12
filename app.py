from flask import Flask, request
from Helpers.ChatbotResponse import ChatbotResponse
from Helpers.Model import Model


app = Flask(__name__)

model = Model()

chatbot = ChatbotResponse(model)

@app.route('/', methods=['GET'])
def index():
    return {"message": "Welcome to machine learning API!"}

@app.route(f'/chatbot/classify', methods=['POST'])
def classification():
    return {
        "class": model.classify(request.json['message'])[0], "message": "Message was classified successfully!"
    }
    
@app.route('/chatbot/welcome', methods=['GET'])
def welcomeHandler():
    l = chatbot.welcome()
    inds = [i for i in range(len(l))]
    welcome_msgs = dict(zip(inds, chatbot.welcome()))
    return {
        "data": welcome_msgs,
        "message": "Welcome messages are here!"
    }

@app.route('/chatbot', methods=['POST'])
def chatbotHandler():
    response = chatbot.get_response(request.json['message'])
    print(type(response))
    return {
        "data": response,
        "message": "Chatbot response is here!"
    }

if __name__ == "__main__":
    app.run(debug=True)