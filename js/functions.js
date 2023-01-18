getElemByXpath = (path) => {
    return document.evaluate(path, document, null, XPathResult.UNORDERED_NODE_SNAPSHOT_TYPE, null);
}

generateSnapShot = (xpath) => {
    return getElemByXpath(xpath);
}

getAllElems = (snapshot) => {
    posts = []
    for(i = 0; i < snapshot.snapshotLength; i++) {
        posts.push(snapshot.snapshotItem(i));
    }
    return posts
}

scrollElem = (index, posts) => {
    i = 0
    while(posts[index].getBoundingClientRect().top == 0 && i < 100) {
        window.scrollBy(0, 500)
        console.log(i)
        console.log(posts[index].innerText)
        i++
    }

    posts[index].scrollIntoView()
}

postText = (post) => {
    return post.innerText
}

postsText = (posts) => {
    data = []
    for(const i in posts)
        data.push(postText(posts[i]))
    return data
}

getPaths = () => {
    let generalPostPath = "/html//div[@class='x1yztbdb x1n2onr6 xh8yej3 x1ja2u2z']//div[@class='x9f619 x1n2onr6 x1ja2u2z x2bj2ny x1qpq9i9 xdney7k xu5ydu1 xt3gfkd xh8yej3 x6ikm8r x10wlt62 xquyuld']//div[2]//div[3]"
    let singleLinePostPath = generalPostPath + "//div[@class='x1pi30zi x18d9i69 x1swvt13 xexx8yu']"
    let postPath = generalPostPath + "//div[@class='x1iorvi4 x1pi30zi xjkvuk6 x1swvt13']//span[@class='x193iq5w xeuugli x13faqbe x1vvkbs x1xmvt09 x1lliihq x1s928wv xhkezso x1gmr53x x1cpjm7i x1fgarty x1943h6x xudqn12 x3x7a5m x6prxxf xvq8zen xo1l8bm xzsf02u x1yc453h']"
    let coloredPostPath = generalPostPath + "//div[@class=' x5yr21d xyqdw3p']/div[@class='xh8yej3']//div[@id]//div[@class='x11i5rnm xat24cr x1mh8g0r x1vvkbs xdj266r']"
    let seeMoreBtns = [postPath + "//div[text()='See more']", coloredPostPath + "//div[text()='See more']"]

    let postTypesPaths = {
        'posts': postPath,
        'slposts': singleLinePostPath,
        'clposts': coloredPostPath,
        'seemorebtns': seeMoreBtns
    }
    
    return postTypesPaths
}

openSeeMoreBtns = (btnsPaths) => {
    for (const i in btnsPaths) {
        let ss = generateSnapShot(btnsPaths[i]);
        let btns = getAllElems(ss);
        for(const i in btns) {
            btns[i].click()
            btns[i].parentElement.click()
        }
    }
}

getPostsText = () => {
    openSeeMoreBtns(paths.seemorebtns) // open see more btns
    
    let posts = [], data = []
    for (const key in paths) {
        if (key == 'seemorebtns') continue; // to skip btns paths
        let ss = generateSnapShot(paths[key]);
        let posts = getAllElems(ss);
        data.push(...postsText(posts));
    }
    
    return data
}

paths = getPaths()
openSeeMoreBtns(paths.seemorebtns) // open see more btns

console.log('done')