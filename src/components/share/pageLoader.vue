<template>
    <main>
        <section class="loaderWrapper">
            <div class="loader"><span></span><span></span><span></span></div>
        </section>
    </main>
</template>

<script>
export default {
    mounted(){
        // // Helpers
        // create = element => document.createElement(element);
        // append = (parent, child) => parent.append(child);
        // select = selector => document.querySelector(selector);


        // const loaderWrapper = select('.loaderWrapper');

        // document.addEventListener('DOMContentLoaded', () => {
        
        // // loaderWrapper.style.display = 'none';
        
        // setTimeout(() => {
        //     loaderWrapper.style.display = 'none';
        // }, 3000)
        // })

        // // O setTimeout é apenas para dar tempo de ver o loader, se for usar em seu site basta remove-lo e descomentar a linha anterior.


        // const section = create('section');
        // const article = create('article');
        // const h1 = create('h1');

        // h1.innerText = 'Loader oculto e conteúdo exibido após o carregamento do DOM';

        // const main = select('main');

        // append(main, section);
        // append(section, article);
        // append(article, h1);
    }
}
</script>

<style lang="scss">
  main {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  width: 100%;
  min-height: 100vh;
  height: 100%;
//   background: #121212;
  // color: #cacaca;
  .loaderWrapper {
    position: fixed;
    background-image: -webkit-gradient(linear, left top, right top, color-stop(0, #151515), to(#000));
    background-image: linear-gradient(90deg, #151515 0, #000);
    
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 100vh;
    top:0;
    z-index: 4;
    .loader {
      width: 100px;
      height: 100px;
      border-radius: 50%;
      perspective: 800px;
      span {
        position: absolute;
        width: 100%;
        height: 100%;
        border-radius: 50%;
        &:nth-child(1) {
          border-bottom: 6px double #00FFFF;
          transform: rotateX(35deg) rotateY(-45deg);
          animation: rotateOne .8s linear infinite;
        }
        &:nth-child(2) {
          border-right: 6px double #89CFF0;
          transform: rotateX(50deg) rotateY(10deg);
          animation: rotateTwo .8s linear infinite;
        }
        &:nth-child(3) {
          border-top: 6px double #088F8F;
          transform: rotateX(35deg) rotateY(55deg);
          animation: rotateThree .8s linear infinite;
        }
      }
    }
  }
}

@keyframes rotateOne {
  to {
    transform: rotateX(35deg) rotateY(-45deg) rotateZ(360deg);
  }
}

@-webkit-keyframes rotateOne {
  to {
    transform: rotateX(35deg) rotateY(-45deg) rotateZ(360deg);
  }
}

@keyframes rotateTwo {
  to {
    transform: rotateX(50deg) rotateY(10deg) rotateZ(360deg);
  }
}

@-webkit-keyframes rotateTwo {
  to {
    transform: rotateX(50deg) rotateY(10deg) rotateZ(360deg);
  }
}

@keyframes rotateThree {
  to {
    transform: rotateX(35deg) rotateY(55deg) rotateZ(360deg);
  }
}

@-webkit-keyframes rotateThree {
  to {
    transform: rotateX(35deg) rotateY(55deg) rotateZ(360deg);
  }
}
</style>