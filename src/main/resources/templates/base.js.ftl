/**
 *
  const styles = [
    '3d.visible',
    '2d.visible',
    'shape3d.transparent',
    'shape3d.opacity',
    '3d.selectable',
    'wf.geometry',            // Boolean 开启线框模式
    'shape3d.blend',          // String 染色 'rgb(0,0,0), rgba(0,0,0,1)'
    'shape3d.reverse.cull'
  ]
 */

import { onBuildingClick, afterBuildingFocused, inBuildingClick, onFloorClick, showFloorTool, hideFloorTool } from './handlers'

export default {
  <#list data as style>
    ${style.name}: {
      beforeStageSet: [],
      afterStageSet: [],
      inStageSet: [],
      styleConfs: [
        <#list style.config as conf>
          ${conf},
        </#list>
      ]
    },
  </#list>
}
