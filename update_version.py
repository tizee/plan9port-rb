#!/usr/bin/env python
import requests
import datetime
import sys
from jinja2 import Template
formula_template="plan9port.template"

# type alias
Date = datetime.datetime
CommitSha = str

# You could actually modfiy following variables for other repos
USER = '9fans'
REPO = 'plan9port'

def get_latest_commit_since(user:str,repo:str,time:Date,branch_name='master') -> CommitSha:
    request_url='https://api.github.com/repos/{user_name}/{repo_name}/commits?since={iso_date}'.format(user_name=user,repo_name=repo,iso_date=time.strftime('%Y-%m-%dT%H:%M:%SZ'))
    resp=requests.get(url=request_url)
    if resp.ok:
        commits=resp.json()
        if len(commits) >0:
            return commits[0]["sha"]
    else:
        print(resp.status_code)
    return ""


class Commit:
    def __init__(self,sha,version):
        self.sha=sha
        self.version=version

def render_jinja2_template(sha:CommitSha):
    current_date=Date.now().strftime("%Y-%m-%d")
    version="{}-{}".format(current_date,sha[:8])
    with open(formula_template) as f:
        read_data = f.read()
        template=Template(read_data)
        contents=template.render(commit=Commit(sha,version))
        f.close()
        return contents
    return ""

def test_jinja2():
    print(render_jinja2_template("bab7b73b85f865d20a5c4f2d78ac9e81b3d39109"))

def test_latset_commit():
    last_90_days = Date.now()-datetime.timedelta(days=90)
    # use master branch by default
    latest_sha=get_latest_commit_since(USER, REPO, last_90_days)
    print(latest_sha)

def main():
    last_90_days = Date.now()-datetime.timedelta(days=90)
    # use master branch by default
    latest_sha=get_latest_commit_since(USER, REPO, last_90_days)
    if len(latest_sha) >0:
        # print("latest commit: {}".format(latest_sha[:8]))
        # render with jinja2 template
        contents=render_jinja2_template(latest_sha)
        if len(contents) > 0:
            with open("./Formula/plan9port.rb","w") as f:
                f.write(contents)
                f.close()
    else:
        print("no new commit")

if __name__ == "__main__":
    if len(sys.argv) >=2:
        if sys.argv[1] == 'test':
            test_latset_commit()
            # test_jinja2()
    else:
        main()
