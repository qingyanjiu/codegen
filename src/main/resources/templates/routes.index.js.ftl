import Vue from 'vue'
import Router from 'vue-router'
import AppMain from '@/layout/AppMain'
// import Login from '@/views-with-api/login'
let routes = []
Vue.use(Router)
console.log(process.env.VUE_APP_ROUTER_MODE)
if (process.env.VUE_APP_ROUTER_MODE == 'api') {
  routes = [
    {
      path: '/',
      redirect: '/visual'
    },
    {
      path: '/visual',
      component: AppMain,
      redirect: '/visual/general',
      name: 'AppMain',
      meta: { name: '智能运行中心' },
      children: [{
        path: 'general',
        component: () => import('@/views-with-api/general/index.vue'),
        name: 'General',
        meta: { loadScene: 'school', sceneStatus: 'school', building: '/visual/general_building', floor: '/visual/general_floor' }
      }, {
        path: 'general_building',
        component: () => import('@/views-with-api/general/building.vue'),
        name: 'GeneralBuilding',
        meta: { loadScene: 'school', sceneStatus: 'building', rootPath: '/visual/general', nextPath: '/visual/general_floor', disDecorator: true }
      }, {
        path: 'general_floor',
        component: () => import('@/views-with-api/general/floor.vue'),
        name: 'GeneralFloor',
        props: true,
        meta: { loadScene: 'school', sceneStatus: 'floor', rootPath: '/visual/general', prevPath: '/visual/general_building' }
      },
      {
        path: 'energy',
        component: () => import('@/views-with-api/energy/viewbasic.vue'),
        name: 'EnergyViewbasic',
        meta: {},
        redirect: '/visual/energy/index',
        children: [
          {
            path: 'index',
            component: () => import('@/views-with-api/energy/index.vue'),
            name: 'EnergyIndex',
            meta: { loadScene: 'school', sceneStatus: 'school', rootPath: '/visual/energy', building: '/visual/energy/building' }
          },
          {
            path: 'elec',
            component: () => import('@/views-with-api/energy/elec.vue'),
            name: 'EnergyIndexElec',
            meta: { loadScene: 'school', sceneStatus: 'school', rootPath: '/visual/energy', building: '/visual/energy/building_elec' }
          },
          {
            path: 'water',
            component: () => import('@/views-with-api/energy/water.vue'),
            name: 'EnergyIndexWater',
            meta: { loadScene: 'school', sceneStatus: 'school', rootPath: '/visual/energy', building: '/visual/energy/building_water' }
          },
          {
            path: 'building',
            component: () => import('@/views-with-api/energy/building.vue'),
            name: 'EnergyBuildingIndex',
            meta: { loadScene: 'school', sceneStatus: 'building', rootPath: '/visual/energy', prevPath: '/visual/energy/index', level: 'building' }
          },
          {
            path: 'building_elec',
            component: () => import('@/views-with-api/energy/buildingelec.vue'),
            name: 'EnergyBuildingElec',
            meta: { loadScene: 'school', sceneStatus: 'building', rootPath: '/visual/energy', prevPath: '/visual/energy/elec', level: 'building' }
          },
          {
            path: 'building_water',
            component: () => import('@/views-with-api/energy/buildingwater.vue'),
            name: 'EnergyBuildingWater',
            meta: { loadScene: 'school', sceneStatus: 'building', rootPath: '/visual/energy', prevPath: '/visual/energy/water', level: 'building' }
          }
        ]
      },
      {
        path: 'security',
        component: () => import('@/views-with-api/security/viewbasic.vue'),
        name: 'ViewBasic',
        meta: {},
        redirect: '/visual/security/index',
        children: [
          {
            path: 'index',
            component: () => import('@/views-with-api/security/index.vue'),
            name: 'SecurityIndex',
            meta: { loadScene: 'school', sceneStatus: 'school', rootPath: '/visual/security', building: '/visual/security/building', floor: '/visual/security/floor' }
          },
          {
            path: 'video',
            component: () => import('@/views-with-api/security/videomonitor.vue'),
            name: 'SecurityVideoMonitor',
            meta: { loadScene: 'school', rootPath: '/visual/security' }
          },
          {
            path: 'gate',
            component: () => import('@/views-with-api/security/securityGate.vue'),
            name: 'SecurityGate',
            meta: { loadScene: 'school', rootPath: '/visual/security' }
          },
          {
            path: 'inspect',
            component: () => import('@/views-with-api/security/securityInspect.vue'),
            name: 'SecurityInspect',
            meta: { loadScene: 'school', rootPath: '/visual/security' }
          },
          {
            path: 'location',
            component: () => import('@/views-with-api/security/warnLocation.vue'),
            name: 'WarnLocation',
            meta: { loadScene: 'school', rootPath: '/visual/security' }
          },
          {
            path: 'building',
            component: () => import('@/views-with-api/security/securityBuilding.vue'),
            name: 'SecurityBuilding',
            meta: { loadScene: 'school', sceneStatus: 'building', rootPath: '/visual/security', nextPath: '/visual/security/floor' }
          },
          {
            path: 'floor',
            component: () => import('@/views-with-api/security/securityFloor.vue'),
            name: 'SecurityFloor',
            meta: { loadScene: 'school', sceneStatus: 'floor', rootPath: '/visual/security', prevPath: '/visual/security/building' }
          }
        ]
      }, {
        path: 'machine_room',
        component: () => import('@/views-with-api/machineRoom/viewBasic.vue'),
        name: 'MachineRoom',
        meta: { loadScene: 'machineRoom', hideNav: true },
        redirect: '/visual/machine_room/index',
        children: [
          {
            path: 'index',
            component: () => import('@/views-with-api/machineRoom/index.vue'),
            name: 'MachineRoomIndex',
            meta: { loadScene: 'machineRoom', hideNav: true }
          },
          {
            path: 'dev',
            component: () => import('@/views-with-api/machineRoom/devDetail.vue'),
            name: 'MachineRoomDev',
            meta: { loadScene: 'machineRoom', hideNav: true }
          },
          {
            path: 'cabinet',
            component: () => import('@/views-with-api/machineRoom/cabinetDetail.vue'),
            name: 'MachineRoomCabinet',
            meta: { loadScene: 'machineRoom', hideNav: true }
          }
        ]
      },
      {
        path: 'air',
        component: () => import('@/views-with-api/airCondition/viewBasic.vue'),
        name: 'AirViewBasic',
        redirect: '/visual/air/index',
        children: [
          {
            path: 'index',
            component: () => import('@/views-with-api/airCondition/index.vue'),
            name: 'AirCondition',
            meta: { loadScene: 'school', sceneStatus: 'school', rootPath: '/visual/air/index', building: '/visual/air/building', floor: '/visual/air/floor' }
          },
          {
            path: 'building',
            component: () => import('@/views-with-api/airCondition/building.vue'),
            name: 'AirBuilding',
            meta: { loadScene: 'school', sceneStatus: 'building', rootPath: '/visual/air/index', prevPath: '/visual/air/index', nextPath: '/visual/air/floor' }
          },
          {
            path: 'floor',
            component: () => import('@/views-with-api/airCondition/floor.vue'),
            name: 'AirFloor',
            meta: { loadScene: 'school', sceneStatus: 'floor', rootPath: '/visual/air/index', prevPath: '/visual/air/building' }
          }
        ]

      },
      {
        path: 'light',
        component: () => import('@/views-with-api/light/viewBasic.vue'),
        name: 'LightViewBasic',
        redirect: '/visual/light/index',
        children: [
          {
            path: 'index',
            component: () => import('@/views-with-api/light/index.vue'),
            name: 'LightIndex',
            meta: { loadScene: 'school', sceneStatus: 'school', rootPath: '/visual/light/index', building: '/visual/light/building', floor: '/visual/light/floor' }
          },
          {
            path: 'building',
            component: () => import('@/views-with-api/light/building.vue'),
            name: 'LightBuilding',
            meta: { loadScene: 'school', sceneStatus: 'building', rootPath: '/visual/light/index', prevPath: '/visual/light/index', nextPath: '/visual/light/floor' }
          },
          {
            path: 'floor',
            component: () => import('@/views-with-api/light/floor.vue'),
            name: 'LightFloor',
            meta: { loadScene: 'school', sceneStatus: 'floor', rootPath: '/visual/light/index', prevPath: '/visual/light/building' }
          }
        ]
      },
      {
        path: 'streetLamp',
        component: () => import('@/views-with-api/streetLamp/viewBasic.vue'),
        name: 'StreetLamp',
        redirect: '/visual/streetLamp/index',
        children: [
          {
            path: 'index',
            component: () => import('@/views-with-api/streetLamp/index.vue'),
            meta: { loadScene: 'school' }
          }
        ]
      }
      ]
    }
    // {
    //   path: '/login',
    //   component: Login
    // }
  ]
} else {
  routes = [
    {
      path: '/',
      redirect: '/visual'
    },
    {
      path: '/visual',
      component: AppMain,
      redirect: '/visual/general',
      name: 'AppMain',
      meta: { name: '智能运行中心' },
      children: [{
        path: 'general',
        component: () => import('@/views-with-demo/general/index.vue'),
        name: 'General',
        meta: { loadScene: 'school', sceneStatus: 'school', building: '/visual/general_building', floor: '/visual/general_floor' }
      }, {
        path: 'general_building',
        component: () => import('@/views-with-demo/general/building.vue'),
        name: 'GeneralBuilding',
        meta: { loadScene: 'school', sceneStatus: 'building', rootPath: '/visual/general', nextPath: '/visual/general_floor', disDecorator: true }
      }, {
        path: 'general_floor',
        component: () => import('@/views-with-demo/general/floor.vue'),
        name: 'GeneralFloor',
        props: true,
        meta: { loadScene: 'school', sceneStatus: 'floor', rootPath: '/visual/general', prevPath: '/visual/general_building' }
      },
      {
        path: 'energy',
        component: () => import('@/views-with-demo/energy/viewbasic.vue'),
        name: 'EnergyViewbasic',
        meta: {},
        redirect: '/visual/energy/index',
        children: [
          {
            path: 'index',
            component: () => import('@/views-with-demo/energy/index.vue'),
            name: 'EnergyIndex',
            meta: { loadScene: 'school', sceneStatus: 'school', rootPath: '/visual/energy', building: '/visual/energy/building' }
          },
          {
            path: 'elec',
            component: () => import('@/views-with-demo/energy/elec.vue'),
            name: 'EnergyIndexElec',
            meta: { loadScene: 'school', sceneStatus: 'school', rootPath: '/visual/energy', building: '/visual/energy/building_elec' }
          },
          {
            path: 'water',
            component: () => import('@/views-with-demo/energy/water.vue'),
            name: 'EnergyIndexWater',
            meta: { loadScene: 'school', sceneStatus: 'school', rootPath: '/visual/energy', building: '/visual/energy/building_water' }
          },
          {
            path: 'building',
            component: () => import('@/views-with-demo/energy/building.vue'),
            name: 'EnergyBuildingIndex',
            meta: { loadScene: 'school', sceneStatus: 'building', rootPath: '/visual/energy', prevPath: '/visual/energy/index', level: 'building' }
          },
          {
            path: 'building_elec',
            component: () => import('@/views-with-demo/energy/buildingelec.vue'),
            name: 'EnergyBuildingElec',
            meta: { loadScene: 'school', sceneStatus: 'building', rootPath: '/visual/energy', prevPath: '/visual/energy/elec', level: 'building' }
          },
          {
            path: 'building_water',
            component: () => import('@/views-with-demo/energy/buildingwater.vue'),
            name: 'EnergyBuildingWater',
            meta: { loadScene: 'school', sceneStatus: 'building', rootPath: '/visual/energy', prevPath: '/visual/energy/water', level: 'building' }
          }
        ]
      },
      {
        path: 'security',
        component: () => import('@/views-with-demo/security/viewbasic.vue'),
        name: 'ViewBasic',
        meta: {},
        redirect: '/visual/security/index',
        children: [
          {
            path: 'index',
            component: () => import('@/views-with-demo/security/index.vue'),
            name: 'SecurityIndex',
            meta: { loadScene: 'school', sceneStatus: 'school', rootPath: '/visual/security', building: '/visual/security/building', floor: '/visual/security/floor' }
          },
          {
            path: 'video',
            component: () => import('@/views-with-demo/security/videomonitor.vue'),
            name: 'SecurityVideoMonitor',
            meta: { loadScene: 'school', rootPath: '/visual/security' }
          },
          {
            path: 'gate',
            component: () => import('@/views-with-demo/security/securityGate.vue'),
            name: 'SecurityGate',
            meta: { loadScene: 'school', rootPath: '/visual/security' }
          },
          {
            path: 'inspect',
            component: () => import('@/views-with-demo/security/securityInspect.vue'),
            name: 'SecurityInspect',
            meta: { loadScene: 'school', rootPath: '/visual/security' }
          },
          {
            path: 'location',
            component: () => import('@/views-with-demo/security/warnLocation.vue'),
            name: 'WarnLocation',
            meta: { loadScene: 'school', rootPath: '/visual/security' }
          },
          {
            path: 'building',
            component: () => import('@/views-with-demo/security/securityBuilding.vue'),
            name: 'SecurityBuilding',
            meta: { loadScene: 'school', sceneStatus: 'building', rootPath: '/visual/security', nextPath: '/visual/security/floor' }
          },
          {
            path: 'floor',
            component: () => import('@/views-with-demo/security/securityFloor.vue'),
            name: 'SecurityFloor',
            meta: { loadScene: 'school', sceneStatus: 'floor', rootPath: '/visual/security', prevPath: '/visual/security/building' }
          }
        ]
      }, {
        path: 'machine_room',
        component: () => import('@/views-with-demo/machineRoom/viewBasic.vue'),
        name: 'MachineRoom',
        meta: { loadScene: 'machineRoom', hideNav: true },
        redirect: '/visual/machine_room/index',
        children: [
          {
            path: 'index',
            component: () => import('@/views-with-demo/machineRoom/index.vue'),
            name: 'MachineRoomIndex',
            meta: { loadScene: 'machineRoom', hideNav: true }
          },
          {
            path: 'dev',
            component: () => import('@/views-with-demo/machineRoom/devDetail.vue'),
            name: 'MachineRoomDev',
            meta: { loadScene: 'machineRoom', hideNav: true }
          },
          {
            path: 'cabinet',
            component: () => import('@/views-with-demo/machineRoom/cabinetDetail.vue'),
            name: 'MachineRoomCabinet',
            meta: { loadScene: 'machineRoom', hideNav: true }
          }
        ]
      },
      {
        path: 'air',
        component: () => import('@/views-with-demo/airCondition/viewBasic.vue'),
        name: 'AirViewBasic',
        redirect: '/visual/air/index',
        children: [
          {
            path: 'index',
            component: () => import('@/views-with-demo/airCondition/index.vue'),
            name: 'AirCondition',
            meta: { loadScene: 'school', sceneStatus: 'school', rootPath: '/visual/air/index', building: '/visual/air/building', floor: '/visual/air/floor' }
          },
          {
            path: 'building',
            component: () => import('@/views-with-demo/airCondition/building.vue'),
            name: 'AirBuilding',
            meta: { loadScene: 'school', sceneStatus: 'building', rootPath: '/visual/air/index', prevPath: '/visual/air/index', nextPath: '/visual/air/floor' }
          },
          {
            path: 'floor',
            component: () => import('@/views-with-demo/airCondition/floor.vue'),
            name: 'AirFloor',
            meta: { loadScene: 'school', sceneStatus: 'floor', rootPath: '/visual/air/index', prevPath: '/visual/air/building' }
          }
        ]

      },
      {
        path: 'light',
        component: () => import('@/views-with-demo/light/viewBasic.vue'),
        name: 'LightViewBasic',
        redirect: '/visual/light/index',
        children: [
          {
            path: 'index',
            component: () => import('@/views-with-demo/light/index.vue'),
            name: 'LightIndex',
            meta: { loadScene: 'school', sceneStatus: 'school', rootPath: '/visual/light/index', building: '/visual/light/building', floor: '/visual/light/floor' }
          },
          {
            path: 'building',
            component: () => import('@/views-with-demo/light/building.vue'),
            name: 'LightBuilding',
            meta: { loadScene: 'school', sceneStatus: 'building', rootPath: '/visual/light/index', prevPath: '/visual/light/index', nextPath: '/visual/light/floor' }
          },
          {
            path: 'floor',
            component: () => import('@/views-with-demo/light/floor.vue'),
            name: 'LightFloor',
            meta: { loadScene: 'school', sceneStatus: 'floor', rootPath: '/visual/light/index', prevPath: '/visual/light/building' }
          }
        ]
      }
      // ,
      // {
      //   path: 'streetLamp',
      //   component: () => import('@/views-with-api/streetLamp/viewBasic.vue'),
      //   name: 'StreetLamp',
      //   redirect: '/visual/streetLamp/index',
      //   children: [
      //     {
      //       path: 'index',
      //       component: () => import('@/views-with-api/streetLamp/index.vue'),
      //       meta: { loadScene: 'school' }
      //     }
      //   ]
      // }
      ]
    }

  ]
}

const routeMap = {}

function getRouteMap(routeList, rootPath = '') {
  routeList.forEach(route => {
    let fullPath = ''
    if (rootPath === '') {
      fullPath = rootPath + route.path
    } else {
      fullPath = rootPath + '/' + route.path
    }
    routeMap[fullPath] = route
    if (!route.meta) {
      route.meta = {}
    }
    if (route.children && route.children.length) {
      getRouteMap(route.children, fullPath)
    }
  })
}

getRouteMap(routes)
for (const key in routeMap) {
  const redirect = routeMap[key].redirect
  if (redirect) {
    const redirectRoute = routeMap[redirect]
    if (redirectRoute && redirectRoute.meta) {
      routeMap[key].meta = Object.assign({}, routeMap[key].meta, redirectRoute.meta)
    }
  }
}

const router = new Router({
  routes
})

export { routeMap }
export default router
