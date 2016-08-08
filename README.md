## Ghost Dockerfile


### Base Docker Image

* [node:4.2](https://registry.hub.docker.com/_/node/)


### Installation

```bash
git clone https://github.com/mmornati/docker-ghostblog.git
cd docker-ghostblog
docker build -t mmornati/docker-ghostblog .
```

### Usage

    docker run -d -p 80:2368 mmornati/docker-ghostblog

#### Customizing Ghost

    docker run -d -p 80:2368 -e [ENVIRONMENT_VARIABLES] -v <override-dir>:/ghost-override mmornati/docker-ghostblog

Environment variables are used to personalise your Ghost Blog configuration. Could be:

* WEB_URL: the url used to expose your blog (default: blog.mornati.net)
* DB_CLIENT: database used to store blog data (default: sqlite3)
* DB_SQLITE_PATH: sqlite data file path (default: /content/data/ghost.db)
* SERVER_HOST: hostname/ip used to expose the blog (default: 0.0.0.0)
* SERVER_PORT: port used by the server (default: 2638).

> NB: Knowing the ghostblog is run using a 'non root user' (ghost), you cannot start the nodejs process on a port less than 1024.

A complete running command line could be:

    docker run -d -p 80:2368 -e WEB_URL=http://test.blog -e SERVER_HOST=12.4.23.5 -e SERVER_PORT=4000 -v /opt/data:/ghost-override dockerfile/ghost

### Changelog

* Fixed problem starting with old middleware file. Just removed the file and using standard Ghostblog functionalities
* Updated Node module to 4.2 version which is now supported by Ghost

### Ghost Updates

#### 0.9.0

* [New] Scheduled posts - tell Ghost to publish your post sometime in the future 🕑
* [New] Configurable blog timezone - super important for making scheduled posts work the way you expect.
* [New] Internal tags (Beta) - use tags for managing content without them appearing in your theme
* [Improved] Install & upgrade process by removing dependency on semver which regularly broke npm
* [Improved] Better error handling for visitors and admin users whilst performing upgrades
* [Fixed] "Access Denied" errors when uploading images
* [Fixed] Editing a post via the API without providing a tags list would delete the post's tags 😱
* [Fixed] Problems running in nested sub-directories, e.g. mysite.com/my/blog
* [Fixed] Session handling on intermittent connections - it should now be easier to stay logged in
* [Changed] Referrer policy changed from origin to origin-when-cross-origin to improve in-site analytics
* [Changed] Node v4 is now the recommended node version for running Ghost 🎉

#### 0.8.0

* [New] Subscribers (Beta) - enable in labs to collect email addresses from your blog
* [New] Slack integration - notify a slack channel whenever a new blog post is published
* [New] Twitter & Facebook support - add your social profiles to your blog and users, get a meta data boost
* [New] HTTP2 Preload headers - get super speed with CloudFlare
* [Changed] Image uploader - improved editor performance and a smoother upload experience
* [Changed] theme API breaking changes - see here for the details
* [Fixed] Errors in JSON-LD structured data output on blog posts & author pages

#### 0.7.9

* [Improved] Static pages now have structured data, just like posts, so they will pass validation for twitter cards and other social media sharing tools.
* [Improved] Relaxed CORS handling, meaning less people should have issues logging in to their blog if their URL isn't configured exactly right.
* [Improved] Draft post slugs (urls) are updated when the title changes, so that you don't get weird half-titles in slugs anymore.
* [Fixed] Static files immediately result in a 404, because trying a filename with a trailing slash on the end is never going to result in a happier ending.
* [Fixed] Incorrect preview link & icon position in the editor making it easier to preview your post by clicking the word "preview" at the bottom of the editor.
* [Fixed] Requesting url as a field from the Posts API didn't return the correct response (Public API Beta).
* [Changed] Trusted domains now require their protocol be included. See below for details (Public API Beta).

#### 0.7.8

* [Fixed] Unable to add an existing tag to a new post

And from 0.7.7...

* [Fixed] Node v4 LTS support handles 4.3 and all future v4 LTS versions 🚀
* [Fixed] Settings cache cleared on import, so your blog will now look correct without needing a restart
* [Fixed] Various issues with navigation - the UI behaves better, and you'll no longer get ignored by {{current}} if you forget a trailing slash.
* [Fixed] API serving invalid status codes, which was a potential source of crashes 💥
* [New] The delete all content button now creates a backup file first... just in case 😉
And much more...
