<script lang="ts">
    import { Col, Row } from "sveltestrap";
    import Item from "./item.svelte";
    import { Option } from "./item.svelte";
</script>

<section>
    <section>
        <Row class="no-gutters">
            <Col md="6" class="d-flex">
                <Item
                    icon_component={Option.CalendarHeart}
                    background_color="#0DCAF0"
                    title="Improve your life"
                    description="not working frees your time to learn a new
				skill, spend more time with family, sleep or
				have fun"
                />
            </Col>
            <Col md="6" class="d-flex">
                <Item
                    icon_component={Option.GraphDown}
                    background_color="#3D8BFD"
                    title="Reduce emissions"
                    description="not working reduces emissions likely more than any of your individual actions"
                />
            </Col>
            <Col md="6" class="d-flex">
                <Item
                    icon_component={Option.BuildingFillExclamation}
                    background_color="#FD9843"
                    title="Highly targeted"
                    description="you better than any advertisment know how much your company is poluting - act proportionally"
                />
            </Col>
            <Col md="6" class="d-flex">
                <Item
                    icon_component={Option.Bullseye}
                    background_color="#E35D6A"
                    title="Highly effective"
                    description="No smear advertisements, public activities or high
					personal risks - act where it impacts the most:
					revenue and productivity"
                />
            </Col>
        </Row>
    </section>
</section>
