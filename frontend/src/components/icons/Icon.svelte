<script context="module" lang="ts">
  export enum IconType {
    Outline = 'Outline',
    Solid = 'Solid',
    Mini = 'Mini'
  }
</script>

<script lang="ts">
  import { onMount, SvelteComponentTyped } from 'svelte';

  export let solid = false;
  export let mini = false;

  let type: IconType = (() => {
    if (solid) return IconType.Solid;
    if (mini) return IconType.Mini;
    return IconType.Outline;
  })();

  export let name: string;
  export let classes = '';

  let Component: typeof SvelteComponentTyped;

  onMount(async () => {
    Component = (await import(`./${name}/${type}.svelte`)).default;
  });
</script>

<span class={classes}>
  <svelte:component this={Component} />
</span>
