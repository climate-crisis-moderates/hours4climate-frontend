<script context="module" lang="ts">
    export enum Option {
        CalendarHeart,
        BuildingFillExclamation,
        Bullseye,
        GraphDown,
    }
</script>

<script lang="ts">
    import { Col, Row } from "sveltestrap";
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

<div style:background={background_color} style:padding="2em">
    <Row>
        <Col md="2">
            <svelte:component
                this={options[icon_component]}
                width={64}
                height={64}
            />
        </Col>
        <Col md="10">
            <h5>{title}</h5>
            <p>{description}</p>
        </Col>
    </Row>
</div>
