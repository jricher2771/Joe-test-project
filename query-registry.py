
import os
import json
import requests

# Queries the local docker registry and returns a list of repositories, in this case just hello. 
# Very dependant on user conforming to semantic versions. 
# Finally lists the tags for hello repository with latest using max(), 

apiversion = "v2"

URL = "http://localhost:5000"

def list_repos():
    req = requests.get(URL+ "/" + apiversion + "/_catalog", verify=False)
    # print(req)
    return json.loads(req.text)["repositories"]

def find_tags(reponame):
    req = requests.get(URL+ "/" + apiversion + "/" + reponame+"/tags/list", verify=False)
    print("\n")
    data =  json.loads(req.content)
    if "tags" in data:
        return data["tags"]


def main(): 
    if URL != "":
        list_of_repos = list_repos()
        print("List of Repositories:\n")
        for x in list_of_repos:
            print(x) 
        
        tags = find_tags("hello")
        
        # Checking if tags conform to semantic version scheme (essentially removing the prepended V). 
        
        tmp = []
        semtags = []
        
        for tag in tags:
            if "v" not in tag:
                tmp.append(tag)
            
        for tag in tmp:
            semtags.append(str(tag))
        
        max_val = max(semtags)
        print("Latest tag: ", max_val)
        
    else:
        print("Please check static URL defined in query-registry.py\n")


if __name__ == "__main__":
    main()