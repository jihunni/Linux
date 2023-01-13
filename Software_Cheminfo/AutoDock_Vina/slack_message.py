def slack_alarm(message):
    """
    message : string
    """
    import os
    from slack import WebClient
    from slack.errors import SlackApiError

    SLACK_API_TOKEN = 'HERE_slack_api_token'
    client = WebClient(token=SLACK_API_TOKEN)

    try:
        response = client.chat_postMessage(channel='#deep-learning',text=message)
        assert response["message"]["text"] == message

        #filepath="./tmp.txt"
        #response = client.files_upload(channels='#random', file=filepath)
        #assert response["file"]  # the uploaded file
    except SlackApiError as e:
        # You will get a SlackApiError if "ok" is False
        assert e.response["ok"] is False
        assert e.response["error"]  # str like 'invalid_auth', 'channel_not_found'
        #print(f"Got an error: {e.response['error']}")

if __name__ == '__main__':
    import argparse

    def get_arguments():
        parser = argparse.ArgumentParser(description="Get a message to send on slack")
        parser.add_argument('message', type=str, help='message to send')
        
        message = parser.parse_args().message

        return message

    message = get_arguments()
    
    slack_alarm(message)
