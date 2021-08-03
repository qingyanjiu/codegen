/* eslint-disable accessor-pairs */
import SceneBase from './SceneBase'
import utilIndex from './utils/school/index'
import { pointList } from '../data/inspect'
import EventBus from '@/utils/EventBus'
import { EVENT_NAMES } from '@/utils/EventUtil'

const whiteimage = require('@/assets/image/white.png')
class School extends SceneBase {
  constructor(name, sctr) {
    super(name, sctr)
    this.src = './scenes/zhyx/zhyx.json'
    this.activeFloorNum = 1
    for (const key in utilIndex) {
      this[key] = utilIndex[key]
    }
  }

  mi3dEvent(e) {
    const { dm3d, g3d } = this
    const { kind, data } = e
    let displayName = ''
    if (data) {
      displayName = data.getDisplayName()
    }

    if (kind === 'clickData') {
      EventBus.$emit(EVENT_NAMES.EVENT_ON_CLICK_DATA, data)
      for (let i = 0; i < pointList.length; i++) {
        if (data.a('posId') == pointList[i].id) {
          this.controler.view2D.showInspect(pointList[i])
          this.goToPlaceFrame(data)
          break
        }
      }

      if (data.a('tag') === 'closeTag') {
        this.backCenter()
      }
      // if (displayName === 'light') {
      //   const list = this.dm3d.getSiblings(data).toArray().filter(d => d.getDisplayName() === 'light')
      //   const idx = list.indexOf(data)
      //   this.controler.view2D.openAirFrame(idx)
      //   this.goToAirFrame(data)
      // }
      // if (displayName === 'air_icon') {
      //   this.controler.view2D.openAirFrame()
      //   this.goToAirFrame(data)
      // }
      // if (displayName === 'gate') {
      //   this.controler.view2D.showVideo(data.getTag())
      //   this.goToPlaceFrame(data)
      // }
      // if (displayName === 'camera') {
      //   this.goToPlaceFrame(data)
      //   this.controler.view2D.showVideo(data.getTag())
      // }
    }
    if (kind === 'onEnter') {
      EventBus.$emit(EVENT_NAMES.EVENT_ON_ENTER, data)
      const { name } = this.controler.view2D.$route

      if (displayName === 'gate' || displayName === 'air_icon' || displayName === 'elelight' || displayName === 'light') {
        if (name !== 'SecurityIndex') {
          document.body.style.cursor = 'pointer'
        }
      }
      if (displayName === '3') {
        document.body.style.cursor = 'pointer'
        data.s({
          // 'shape3d.blend': 'rgba(32,224,202,0.5)'
        })
      }
    }
    if (kind === 'onLeave') {
      EventBus.$emit(EVENT_NAMES.EVENT_ON_LEAVE, data)
      if (displayName === 'gate' || displayName === 'air_icon' || displayName === 'elelight' || displayName === 'light') {
        document.body.style.cursor = 'initial'
      }
      if (displayName === '3') {
        document.body.style.cursor = 'initial'
        data.s({
          // 'shape3d.blend': ''
        })
      }
    }
    if (kind === 'doubleClickData') {
      EventBus.$emit(EVENT_NAMES.EVENT_ON_DOUBLE_CLICK_DATA, data)
      if (displayName === '3') {
        this.focusedBuilding = data
        const path = this.getNextPath()
        if (path) {
          // const query = {
          //   attr: 'focusedBuilding',
          //   id: data.getId()
          // }
          this.controler.view2D.$router.push(path)
        }
      }
      if (displayName === 'shiti') {
        console.log(data)
        if (this.isFloorFocused) return
        this.focusedFloor = data
        const path = this.getNextPath(true)
        if (path) {
          this.controler.view2D.$router.push(path)
        }
      }
      if (displayName === '机房') {
        this.floorVirtualShowed = false
        this.controler.view2D.$router.push('/visual/machine_room')
      }
    }
    if (kind === 'doubleClickBackground') {
      EventBus.$emit(EVENT_NAMES.EVENT_ON_DOUBLE_CLICK_BG, data)
      if (this.inAnimation) return
      if (this.isBuildFocused && !this.isFloorFocused) {
        const path = this.getNextPath()
        if (path) {
          this.controler.view2D.$router.replace(path)
        }
        this.buildingBackToIndex()
      }
      if (this.isFloorFocused) {
        this.controler.view2D.$router.replace(this.getNextPath())
        this.floorBackToBuilding()
      }
    }
  }
  getNextPath(nextPath) {
    const meta = this.controler.view2D.$route.meta
    const sceneStatus = meta.sceneStatus
    let path = ''
    switch (sceneStatus) {
      case 'school':
        path = meta.building
        break
      case 'building':
        if (nextPath) {
          path = meta.nextPath
        } else {
          path = meta.prevPath || meta.rootPath
        }
        break
      case 'floor':
        path = meta.prevPath
        break
    }
    return path
  }

  showHideHomeBuild(config) { // config {tag:'',visible:''}
    const { tag = '', visible = false } = config
    this.dm3d.getDataByTag(tag).s({
      '3d.visible': visible,
      '2d.visible': visible
    })
  }

  // // 隐藏摄像头
  // hideCamera(flag) {
  //   const nodeTagList = ['摄像头教学楼', '摄像头公寓楼', '摄像头主楼', '摄像头图书馆']
  //   nodeTagList.forEach(item => {
  //     this.dm3d.getDataByTag(item).s({
  //       '3d.visible': flag,
  //       '2d.visible': flag
  //     })
  //   })
  // }

  // 设置鼠标移入显示边框效果
  setHighlightMode(filterHandler) {
    this.g3d.setHighlightMode('mouseover')
    this.g3d.setHighlightWidth(2)
    this.g3d.setHighlightColor('#20e0ca')
    const nodeNameList = ['shiti', '3']
    this.g3d.getHighlightHelper().setFetchTargetFunc((nodes) => {
      return new ht.List(nodes).toArray().filter(item => {
        return nodeNameList.indexOf(item.getDisplayName()) > -1
      })
    })
  }

  // 关闭视频弹框事件
  closeVideoDialog() {
    this.activeCamera.a('isActive', false)
  }

  openAnim() {
    const cameraPath = this.dm3d.getDataByTag('openPath')
    const roamingCenter = this.dm3d.getDataByTag('roamingCenter')
    this.g3d.setCenter(roamingCenter.getPosition3d())
    this.isRoaming = true
    this.mapInteractor.maxPhi = Math.PI * 2
    ht.Default.startAnim({
      duration: 3000,
      easing: this.Easing.easeIn,
      finishFunc: () => {
        this.mapInteractor.maxPhi = Math.PI * 5 / 12
        this.isRoaming = false
      }, // 动画结束后调用的函数。
      action: (v) => {
        const length = this.g3d.getLineLength(cameraPath)
        const offset = this.g3d.getLineOffset(cameraPath, length * v)
        const point = offset.point
        const px = point.x
        const py = point.y
        const pz = point.z
        this.g3d.setEye(px, py, pz)
      }
    })
  }

  getNodes() {
    this.roomGroupList = this.dm3d.getDataByTag('roomGroup').getChildren().toArray().sort((a, b) => {
      const aNum = parseInt(a.getDisplayName().split('_')[1])
      const bNum = parseInt(b.getDisplayName().split('_')[1])
      return aNum - bNum
    })
    this.floorTempTags = this.dm3d.getDataByTag('floorTempTag').getChildren().toArray().sort((a, b) => {
      const aNum = parseInt(a.getDisplayName())
      const bNum = parseInt(b.getDisplayName())
      return aNum - bNum
    })
    const floors = this.dm3d.getDataByTag('floors')
    this.floorVirtualList = floors.getChildren().toArray().sort((a, b) => {
      const aNum = parseInt(a.getDisplayName().replace('floor', ''))
      const bNum = parseInt(b.getDisplayName().replace('floor', ''))
      return aNum - bNum
    })
    this.floorVirtualList.forEach(item => {
      const p3 = item.p3()
      if (!item.a('p3')) {
        item.a('p3', p3)
      }
      item.p3(p3[0], 0, p3[2])
    })
    this.floorEntity = this.dm3d.getDataByTag('floor')
    this.floorEntity.a('p3', this.floorEntity.p3())
    this.getInspectPoints()
  }

  afterLoad() {
    // console.log('school加载完成！')
    this.setHighlightMode()
    this.getNodes()
    // this.g3d.setCenter(this.dm3d.getDataByTag('roamingCenter').getPosition3d())
    this.setDistanceScope(10, 6000)

    // 设置阴影角度
    this.g3d.setShadowDegreeX(50)
    this.g3d.setShadowDegreeZ(-10)
    this.eventListener()
  }

  eventListener() {
    this.onEvent('onLineClick', this.onLineClick, this)
    this.onEvent('onBulbClick', this.onBulbClick, this)
  }
}

export default School
