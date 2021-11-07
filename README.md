# Django Content Aggregator

Following the example here - https://realpython.com/build-a-content-aggregator-python/

### Things I did differently

WSL2 does not natively expose the ports you want to. I need to 

- add your IP to `settings.py`, you can get it from the logs

```python
ALLOWED_HOSTS = ["172.14.0.100"]
```
Or simply set it to wildcard
```
ALLOWED_HOSTS = ["*"]
```
- Then run the server with
    - `python manage.py runserver 0.0.0.0:8000`

# Adding a new podcast

- edit the `/podcasts/management/commands/startjobs.py` file
- add another block like this
    ```
    def fetch_ALAB_episodes():
        """Fetches new episodes from RSS for the Talk Python to Me Podcast."""
        _feed = feedparser.parse("https://feeds.soundcloud.com/users/soundcloud:users:684690716/sounds.rss")
        save_new_episodes(_feed)
    ```
- Add to Command class
    ```
    class Command(BaseCommand):
        def handle(self, *args, **options):
            fetch_realpython_episodes()
            fetch_ALAB_episodes()
    ```
- Then add it to the scheduler
    ```
        scheduler.add_job(
            fetch_ALAB_episodes,
            trigger="interval",
            minutes=240,
            id="ALAB",
            max_instances=1,
            replace_existing=True,
        )
        logger.info("Added job: ALAB Feed.")
    ```

#