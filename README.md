Welcome to C5 Zine
=================

This is where we store our zine which was originally
written on [https://zine-machine.glitch.me/](https://zine-machine.glitch.me/).

Development
-----------

We're using [middleman](https://middlemanapp.com/) to help streamline
building and deploying this site.

Read more about middleman with the link above.

Each issue should get a `data/issue#.json` file which contains a list
of images and a pointer to the image directory (which is likely something
like `/source/images/issue#/`.

For example, our `data/issue1.json` looks like this.

```json
{
  "asset_dir": "issue1/",
  "number_of_sheets": 1,
  "pages": [
    {
      "title": "Nikki Thayer",
      "image":  "page1-nicole-thayer.png",
      "author" : "Social Distancing Issue 1"
    },
    { ... more pages }
  ]
}
```

The `index.html.erb` file then has access to that data so you can easily
loop through images and build the new issue.

### Steps to build issue next.

Let's assume the next issue is #2.

* Get your image files and content together.
* Copy `source/index.html.erb` to `source/issue1.html.erb`
* Add and edit `data/issue2.json` to include the new set of data
* Edit references in `source/index.html.erb` from `data.issue1` to `data.issue2`

That should be it.

You can run `bundle exec rake serve` (or `bundle exec middleman server`) to see the local version (at `http://localhost:4567`).

Deployment
----------

We've included [middleman-github-deploy or mgd](https://github.com/hovancik/middleman-github-deploy)https://github.com/hovancik/middleman-github-deploy)
This task simply runs `mgd`

`bundle exec rake deploy`

Visit the newly deployed site at `https://carbonfive.github.io/c5-zine`

   
