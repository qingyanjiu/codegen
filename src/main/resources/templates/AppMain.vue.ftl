<template>
  <div class="visual-warpper">
    <div id="htCont" class="ht-cont" />
    <scale-box style="pointer-events: none" :full-width="true">
      <transition name="slide-down">
        <Header />
      </transition>
      <transition name="slide-left">
        <Nav v-if="showNav" />
      </transition>
      <transition name="fade">
        <Tools :visible="showTools" />
      </transition>
      <transition name="fade">
        <FloorTool v-show="showFloorTool" />
      </transition>
      <transition name="fade-transform" mode="out-in">
        <router-view v-if="controler" />
      </transition>
      <transition v name="fade">
        <!-- <Loading v-if="!sceneLoaded && show3D" /> -->
      </transition>
    </scale-box>
  </div>
</template>

<script>
import Header from '@/layout/components/Header'
import ScaleBox from '@/components/ScaleBox'
import Nav from '@/layout/components/Nav'
import Tools from '@/layout/components/Tools'
import FloorTool from '@/components/floorTool'

import createScript from '@/utils/createScript'
import scenesMap from '@/scenes/scenesMap'
import SceneBuilder from '@/utils/visual/SceneBuilder'
import Decorator from '@/utils/visual/Decorator'
import { stageList, baseStage } from '@/scenes/stages/index'

import Controler from '@/utils/visual/Controler.js'
import { mapGetters } from 'vuex'
export default {
  name: 'VisualMain',
  components: {
    ScaleBox,
    Header,
    Nav,
    Tools,
    FloorTool
  },
  data() {
    return {
      controler: null
    }
  },
  computed: {
    ...mapGetters(['showTools', 'showFloorTool', 'showNav'])
  },
  watch: {
    // sceneLoaded(val) {
    //   if (val) {
    //     window.controler.emitEvent('openAnim')
    //   }
    // }
  },
  created() {
  },
  mounted() {
    const htConfig = {
      Default: {
        mockTouch: true,
        convertURL: (url) => 'assets/' + url
      }
    }
    // 先初始一个Controler --> 初始场景  --> 关联 controler 与 场景 并加载场景内容 (setScenesMap)
    const _this = this
    createScript(['libs/plugin/ht-obj.js', // obj模型插件
      'libs/plugin/ht-modeling.js', // 建模插件
      'libs/plugin/ht-quickfinder.js', // 快速查找插件
      'libs/plugin/ht-thermodynamic.js']) // 热力云图插件
      .then(() => {
        if (!this.controler) {
          const controler = this.controler = window.controler = new Controler()
          const scenes = new SceneBuilder(document.getElementById('htCont'), htConfig)
          const decorator = new Decorator(stageList, baseStage)
          controler.setScenes(scenes).setScenesMap(scenesMap).setDecorator(decorator)

          _this.$store.commit('visual/setSceneLoaded', false)
          let modelSize = 0
          ht.Default.handleModelLoaded = () => {
            modelSize++
            console.log(modelSize, 'modelSize1')
            if (modelSize === 13) {
              setTimeout(() => {
                console.log('run', this.$route)
                window.controler.decorator.decoratorRun(this.$route)
                _this.$store.commit('visual/setSceneLoaded', true)
              }, 1000)
            }
          }
          controler.set2DView(this)
          controler.loadScene(this.$route.meta.loadScene)
        }
      })
      .catch((e) => {
        console.log(e)
      })
  }
}
</script>

<style lang="scss" scoped>
.visual-warpper {
  position: relative;
  width: 100%;
  height: 100%;
  overflow: hidden;
  user-select: none;
  background: #275e82;
  .ht-cont {
    position: absolute;
    left: 0;
    top: 0;
    right: 0;
    bottom: 0;
  }
}
</style>
