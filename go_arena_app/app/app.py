# from dlgo.agent.naive import RandomBot
# from dlgo.httpfrontend.server import get_web_app

# random_agent = RandomBot()
# web_app = get_web_app({'random': random_agent})
# web_app.run(host='0.0.0.0', port=5000)

from flask import Flask

app = Flask(__name__)

@app.route('/')
def welcome():
    return "placeholder for go bot demo"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)