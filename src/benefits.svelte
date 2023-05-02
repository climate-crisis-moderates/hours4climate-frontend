<script lang="ts">
    import Item from "./item.svelte";
    import { Option } from "./item.svelte";
</script>

<section>
    <div class="row g-0">
        <div class="col-md-6" style:background="#0DCAF0">
            <Item
                icon_component={Option.CalendarHeart}
                title="Improve your life"
                description="not working frees your time to learn a new
				skill, spend more time with family, sleep or
				have fun"
            />
        </div>
        <div class="col-md-6" style:background="#3D8BFD">
            <Item
                icon_component={Option.GraphDown}
                title="Reduce emissions"
                description="not working reduces emissions likely more than any of your individual actions"
            />
        </div>
        <div class="col-md-6" style:background="#FD9843">
            <Item
                icon_component={Option.BuildingFillExclamation}
                title="Highly targeted"
                description="you better than any advertisment know how much your company is poluting - act proportionally"
            />
        </div>
        <div class="col-md-6" style:background="#E35D6A">
            <Item
                icon_component={Option.Bullseye}
                title="Highly effective"
                description="No smear advertisements, public activities or high
					personal risks - act where it impacts the most:
					revenue and productivity"
            />
        </div>
    </div>
</section>
