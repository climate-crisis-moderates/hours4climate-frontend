<script context="module" lang="ts">
    export enum Option {
        CalendarHeart,
        BuildingFillExclamation,
        Bullseye,
        GraphDown,
    }
</script>

<script lang="ts">
    import Bullseye from "svelte-bootstrap-icons/lib/Bullseye.svelte";
    import CalendarHeart from "svelte-bootstrap-icons/lib/CalendarHeart.svelte";
    import BuildingFillExclamation from "svelte-bootstrap-icons/lib/BuildingFillExclamation.svelte";
    import GraphDown from "svelte-bootstrap-icons/lib/GraphDown.svelte";

    export let title: string;
    export let description: string;

    const options = {
        [Option.CalendarHeart]: CalendarHeart,
        [Option.BuildingFillExclamation]: BuildingFillExclamation,
        [Option.Bullseye]: Bullseye,
        [Option.GraphDown]: GraphDown,
    };
    export let icon_component: Option;
</script>

<div style:padding="2em" style:color={"white"} class="text-center">
    <svelte:component this={options[icon_component]} width={64} height={64} />
    <h5>{title}</h5>
    <p>{description}</p>
</div>
