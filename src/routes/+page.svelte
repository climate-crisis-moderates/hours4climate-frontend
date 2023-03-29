<script lang="ts">
	import { onMount, onDestroy } from "svelte";
	import { Col, Row } from "sveltestrap";
	import Bullseye from "svelte-bootstrap-icons/lib/Bullseye.svelte";
	import CalendarHeart from "svelte-bootstrap-icons/lib/CalendarHeart.svelte";
	import BuildingFillExclamation from "svelte-bootstrap-icons/lib/BuildingFillExclamation.svelte";
	import GraphDown from "svelte-bootstrap-icons/lib/GraphDown.svelte";

	import Nested from "../logo.svelte";
	import Form from "../form.svelte";

	import { PUBLIC_API_ENDPOINT } from "$env/static/public";

	let combined_hours: Array<Array<string>> = [];

	async function fetchData() {
		combined_hours = await fetch(PUBLIC_API_ENDPOINT + "/api/summary").then(
			(response) => response.json()
		);
	}

	const pollData = () => {
		return setTimeout(() => {
			fetchData().then(() => pollData());
		}, 1000 * 10); // every 10s
	};

	let poll_id: number = 0;
	onMount(() => {
		poll_id = pollData();
	});

	onDestroy(() => {
		clearTimeout(poll_id);
	});
</script>

<svelte:head>
	<link
		rel="stylesheet"
		href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	/>
</svelte:head>

<main class="container">
	<div class="text-center">
		<Nested class="img-responsive center-block" />
	</div>
	<h1 class="text-center">Work less without disclosing it</h1>

	<h4 class="text-center">
		a cost-effective civil disobedience action to tackle climate crisis
	</h4>
	<p>
		Time is your biggest asset - work less without disclosing it to your
		employer based on your risk tolerance and their behavior towards
		climate. We suggest 30 minutes a day (2.5 hours/week), and adjust to
		your liking on a monthly basis.
	</p>

	<Form />

	<h2>Why</h2>
	<Row>
		<Col class="d-flex align-items-stretch mt-3">
			<div class="card">
				<div class="card-body">
					<p class="card-text text-center">
						<CalendarHeart width={64} height={64} />
					</p>
					<h5 class="card-title">Improve your life</h5>
					<p class="card-text">
						not working frees your time to learn a new skill, spend
						more time with family, sleep or have fun.
					</p>
				</div>
			</div>
		</Col>
		<Col class="d-flex align-items-stretch mt-3">
			<div class="card">
				<div class="card-body">
					<p class="card-text text-center">
						<GraphDown width={64} height={64} />
					</p>
					<h5 class="card-title">Reduce CO2 emissions</h5>
					<p class="card-text">
						not working reduces economical output by a multiplier of
						your salary, which reduces CO2 emissions proportionally.
					</p>
				</div>
			</div>
		</Col>
		<Col class="d-flex align-items-stretch mt-3">
			<div class="card">
				<div class="card-body">
					<p class="card-text text-center">
						<BuildingFillExclamation width={64} height={64} />
					</p>
					<h5 class="card-title">Target companies</h5>
					<p class="card-text">
						you better than any advertisment know how much your
						company is poluting - act proportionally.
					</p>
				</div>
			</div>
		</Col>
		<Col class="d-flex align-items-stretch mt-3">
			<div class="card">
				<div class="card-body">
					<p class="card-text text-center">
						<Bullseye width={64} height={64} />
					</p>
					<h5 class="card-title">Highly effective</h5>
					<p class="card-text">
						No smear advertisements, public activities or high
						personal risks - act where it impacts the most, growth
						and productivity.
					</p>
				</div>
			</div>
		</Col>
	</Row>

	<h2 class="mt-3">Pledges around the world</h2>

	<table class="table mt-3">
		<thead>
			<tr>
				<th scope="col">Country</th>
				<th scope="col">Hours/week</th>
				<th scope="col">Persons</th>
			</tr>
		</thead>
		<tbody>
			{#each combined_hours as country_hours}
				<tr>
					<td>{country_hours[0]}</td>
					<td>{country_hours[1]}</td>
					<td>{country_hours[2]}</td>
				</tr>
			{/each}
		</tbody>
	</table>

	<footer class="mt-3">
		<Row>
			<Col>
				<p>
					Improve us on <a
						href="https://github.com/climate-crisis-moderates"
						>Github</a
					>
				</p>
			</Col>
			<Col>
				<p>
					Join us on <a href="https://discord.gg/FgcWVbypqU"
						>Discord</a
					>
				</p>
			</Col>
		</Row>
	</footer>
</main>
