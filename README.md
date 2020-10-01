Welcome to C5 Zine
=================

Hosted on github : http://carbonfive.github.io/c5-zine/

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

### NOTES about the data file

The shape of every entry in your `issue.json` file *must* be the same.
```json
{
  "partial_name": "",
  "title": "",
  "image":  "",
  "author":  ""
}
```
The values can all be empty which will generate an empty page, but they must all
be present for each entry.

For images, the `image` should live under the specified `asset_dir` as noted above.
For text (poetry, prose or other general html content), you can use `partial_name`
to specify the partial that contains that content.  Partials can be in the `/source`
directory.  The filename should start with an underscore but you don't need an
underscore in the data file.

For example, an entry like
```json
{
  "partial_name": "issue2/poem",
  "title": "",
  "image":  "",
  "author":  ""
}
```

will load `source/issue2/_poem.erb` content up for that page.  You may have to add
styling to the scss files to accommodate.  We use this system to load the footer
on the last page.

Deployment
----------

We've included [middleman-github-deploy or mgd](https://github.com/hovancik/middleman-github-deploy)https://github.com/hovancik/middleman-github-deploy)
This task simply runs `mgd`

`bundle exec rake deploy`

Visit the newly deployed site at `https://carbonfive.github.io/c5-zine`

   
