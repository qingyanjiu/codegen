export default {
  event: '${routePath}',
  stage: {
    sceneType: '${sceneType!}',
    config: [
        <#list configList as config>
            {
              nodes: [${config.nodes}],
              style: {
                ${config.style}
              }
            },
          </#list>
    ]
  },
  beforeStageSet: [
    ${beforeStageSetFunctionNames!}
  ],
  afterStageSet: [
    ${afterStageSetFunctionNames!}
  ],
  inStageSet: [],
  onLeave: [
    ${onLeaveFunctionNames!}
  ]
}

${paramsDef!}

${functionDef!}

