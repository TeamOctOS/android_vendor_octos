##How to use Gerrit

**We're open source, and patches are always welcome!**

Register at [Gerrit Code Review] (http://review.teamoctos.com:8080/#/q/status:open) and use the username that you registered with when using git-review.
Make sure to add your ssh keys to your Gerrit profile.

Commit your patches in a single commit.

**You can send patches by using these commands:**

**convential method:**

    sudo apt-get install git-review
    cd <project>
    <make edits>
    git add -A
    git commit -m "Message"
    git push ssh://<username>@review.teamoctos.com:29418/<project> HEAD:refs/for/oct-14.1

**The git-review package will only have to be installed once.**

**If you are going to make additional edits, just repeat steps, but instead of using:**

    git commit -m "Message"

use:

    git commit --amend

**Gerrit will recognize it as a new patch-set.**

####Important:
**If you are doing a cherry pick of a patch from another author, Please use the appropriate credits.
This means that you must use the name of the author and the date of the original commit.
The original author devotes his time and effort to do so and it is not fair if you remove the credits.
please respect the rules.**

**You can take this line of command to set the author and original date of commit:**

    git commit --amend --author "" --date ""

**example:**

    git commit --amend --author "J.A.R.V.I.S <jarvis@stark.com>" --date "Jan 23, 2017 8:28 PM"

**To view the status of your and others' patches, visit [Gerrit Code Review] (http://review.teamoctos.com:8080/#/q/status:open)**
