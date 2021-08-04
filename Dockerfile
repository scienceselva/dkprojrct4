FROM python:3.7.3-stretch

#Working directory
WORKDIR /app

#copy cource code to / app directory
COPY . app.py /app/

# install the requirements ( pip upgrde to make sure all commands work)
RUN pip3 install -r requirements.txt

# Expose port 80
EXPOSE 80

## Step 5:
# Run app.py at container launch
#CMD ["make", "run-app"]
#CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
CMD ["python", "app.py"]
