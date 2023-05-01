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

    export let background_color: string;
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

<div
    style:background={background_color}
    style:padding="2em"
    style:color={"white"}
    class="text-center"
>
    <svelte:component this={options[icon_component]} width={64} height={64} />
    <h5 style:padding-bottom="1em" style:padding-top="1em">{title}</h5>
    <div class="text-wrap">
        <p>{description}</p>
    </div>
</div>
