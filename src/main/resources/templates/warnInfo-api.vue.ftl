<template>
  <div class="warn">
    <ul class="warn_info">
      <li
        v-for="item in alertTypes"
        :key="item.id"
        :class="'alert-type ' + (item.code == activeType ? 'alert-active' : '')"
        @click="switchAlertList(item)"
      >
        <p :class="item.class">{{ item.number }}</p>
        <div class="warn_info_item">
          <img :src="item.img" alt="">
          <span>{{ item.name }}</span>
        </div>
      </li>
    </ul>
    <div class="warn_list_wrap" :style="{height:scrollHight+'px'}">
      <div class="list_wrap" :style="{height:scrollHight+'px'}">
        <div v-for="item in displayAlertList" :key="item.id" class="warn_item" @click="goTo(item)">
          <div class="item">
            <img :src="alertTypes[activeType].img" alt="" class="item_img">
            <span class="item_title">{{ item.title }}</span>
            <span class="item_time">{{ item.date }}</span>
            <div :style="{clear:'both'}" />
          </div>
          <p class="content">{{ item.content }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Vue from 'vue'
export default {
  name: 'WarnInfo',
  props: {
    scrollHight: { // 66一个
      type: String,
      default: '135'
    },
    alertList: {
      type: Object,
      default: () => {
        return {
          3: [],
          2: [],
          1: [],
          0: []
        }
      }
    },
    activeAlertType: {
      type: String,
      default: '3'
    }
  },
  data() {
    return {
      alertTypes: {
        3: { code: '3', name: '严重', class: 'warn_info_one', img: require('../assets/image/9.png'), number: 0 },
        2: { code: '2', name: '重要', class: 'warn_info_two', img: require('../assets/image/10.png'), number: 0 },
        1: { code: '1', name: '一般', class: 'warn_info_three', img: require('../assets/image/11.png'), number: 0 },
        0: { code: '0', name: '提示', class: 'warn_info_four', img: require('../assets/image/31.png'), number: 0 }
      },
      displayAlertList: [],
      activeType: 3
    }
  },
  watch: {
    alertList: {
      handler: function() {
        var self = this
        this.updateAlertNumber()
        this.displayAlertList = this.alertList[this.activeType]
      },
      deep: true
    }
  },
  mounted() {
    this.updateAlertNumber()
    this.activeType = this.activeAlertType
    this.displayAlertList = this.alertList[this.activeType]
  },
  methods: {
    goTo(item) {
      const config = { visible: true, fn: 'backToIndex' }
      this.$store.commit('visual/setShowBackConfig', config)
      this.$emit('goTo', item)
    },
    updateAlertNumber() {
      for (const k in this.alertTypes) {
        if (this.alertList[k]) {
          Vue.set(this.alertTypes[k], 'number', this.alertList[k].length)
        }
      }
    },
    switchAlertList(alert) {
      this.activeType = alert.code
      this.displayAlertList = this.alertList[this.activeType]
    }
  }
}
</script>
<style lang="scss" scoped>
.warn{
    width: 100%;
    .warn_info{
        display: flex;
        justify-content: space-between;
        flex-direction: row-reverse;
        .warn_info_one{
            font-weight: 400;
            color: #F55D3A;
            font-size: 20px;
            text-indent: 30px;
          }
          .warn_info_two{
            font-weight: 400;
            color: #E1CD25;
            font-size: 20px;
            text-indent: 30px;
          }
          .warn_info_three{
            font-weight: 400;
            color: #20E0CA;
            font-size: 20px;
            text-indent: 30px;
          }
          .warn_info_four{
            font-weight: 400;
            color: #20E091;
            font-size: 20px;
            text-indent: 30px;
            padding-right: 27px;
          }
        .warn_info_item{
          margin-top: 9px;
          img{
            width: 16px;
            height: 16px;
            vertical-align: middle;
          }
          span{
           display: inline-block;
           color: white;
           font-size: 14px;
           font-weight: 300;
           vertical-align: middle;
           margin-left: 7px;
          }
        }
        .alert-type {
          cursor: pointer;
          width: 70px;
          height: 60px;
          border-radius: 10%;
          padding: 4px 6px;
          margin: auto;
        }
        .alert-active {
          background-color:rgba(255, 255, 255, 0.2);
        }
        .alert-type:hover {
          background-color:rgba(255, 255, 255, 0.2);
        }
      }
      .warn_list_wrap{
        width: 377px;
        height: 200px;
        overflow: hidden;
        // &::-webkit-scrollbar {
        //   display: none;
        // }
        .list_wrap{
          width:394px;
          height: 200px;
          overflow-x: hidden;
          overflow-y:auto;
          .warn_item{
          width: 378px;
          height: 55px;
          background: rgba(41, 68, 105, 0.3);
          margin-top: 9px;
          overflow: hidden;
          cursor: pointer;
            .item{
              margin: 9px 0;
              .item_img{
                width: 16px;
                height: 16px;
                margin-left: 8px;
                margin-right: 8px;
              }
            .item_title{
              color: #FFFFFF;
              font-size: 14px;
            }
            .item_time{
              color: #FFFFFF;
              float: right;
              margin-right: 15px;
              font-size: 14px;
            }
          }
          .content{
            width: 90%;
            height: 12px;
            font-size: 12px;
            opacity: 0.45;
            color: #FFFFFF;
            margin-left: 31px;
          }
        }

        }

      }
    }
</style>
