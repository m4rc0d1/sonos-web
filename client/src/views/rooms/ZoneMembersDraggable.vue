<template>
  <draggable class="draggable"
    v-model="zoneMembersCopy"
    :group="{
      name: 'zoneGroupMembers',
      put: ['zoneGroup', 'zoneGroupMembers'],
      pull: ['zoneGroupMembers']
    }"
    :delay-on-touch-only="true"
    :delay="450"
    :touch-start-threshold="8"
    :force-fallback="true"
    :scroll="true"
    :bubble-scroll="true"
    :scroll-sensitivity="120"
    :scroll-speed="10"
    :fallback-on-body="true"
    fallback-class="member-zone-fallback"
    chosen-class="member-zone-chosen"
    drag-class="member-zone-drag"
    ghost-class="member-zone-ghost"
    :sort="false"
    draggable=".member-zone">
    <zone-member-chip v-for="member in zoneMembersCopy" :key="member.id"
      :zoneMember="member">
    </zone-member-chip>
  </draggable>
</template>

<script>
import draggable from 'vuedraggable';
import ZoneMemberChip from '@/views/rooms/ZoneMemberChip.vue';

export default {
  name: 'ZoneMembersDraggable',
  components: { draggable, ZoneMemberChip },
  props: {
    zoneMembers: {
      type: Array,
      required: true,
    },
  },
  computed: {
    zoneMembersCopy: {
      get() {
        return this.zoneMembers;
      },
      set(members) {
        this.$emit('zoneMembersChanged', members);
      },
    },
  },
};
</script>

<style>
.member-zone.member-zone-chosen,
.member-zone.member-zone-drag {
  transform: scale(1.04);
  box-shadow: 0 10px 24px rgba(0, 0, 0, 0.28);
  z-index: 3;
}

.member-zone.member-zone-ghost {
  opacity: 0.35;
}

.member-zone.member-zone-fallback {
  transform: scale(0.7);
  transform-origin: center center;
}
</style>
