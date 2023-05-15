<script lang="ts">
    import Select from "svelte-select";
    import HCaptcha from "svelte-hcaptcha";

    import {
        PUBLIC_API_ENDPOINT,
        PUBLIC_HCAPTCHA_KEY,
    } from "$env/static/public";

    import type { Country, Explanation } from "./schema.svelte";
    import { build_explanation } from "./schema.svelte";

    export let countries: Map<string, Country>;

    async function get_countries(text: string) {
        if (text != "") {
            return Array.from(countries.values())
                .filter((country: Country) => {
                    return country.name
                        .toLowerCase()
                        .includes(text.toLowerCase());
                })
                .map((country: Country) => {
                    return {
                        value: country.id,
                        label: country.name,
                    };
                });
        } else {
            return Array.from(countries.values()).map((country: Country) => {
                return {
                    value: country.id,
                    label: country.name,
                };
            });
        }
    }

    let captcha: HCaptcha;

    const handleError = () => {
        captcha.reset();
    };

    // whether the pledge has been submitted (once per page)
    let can_submit = true;
    let token: string | null = null;

    let selected_country: any = null;
    let hours: number | null = null;

    let explanation: Explanation | null = null;

    $: {
        if (selected_country !== null && hours != null) {
            explanation = build_explanation(
                countries,
                selected_country["value"],
                hours
            );
        }
    }

    let isHuman = (event: any) => {
        token = event["detail"]["token"];
    };

    async function pedge() {
        return await fetch(PUBLIC_API_ENDPOINT + "/api/pledge", {
            method: "POST",
            body: JSON.stringify({
                token,
                country: selected_country["value"],
                hours,
            }),
            headers: {
                Accept: "application/json",
                "Content-Type": "application/json",
            },
        })
            .then(() => {
                can_submit = false;
            })
            .catch((error) => {
                console.log(error);
                can_submit = false;
            });
    }
</script>

<div class="container-fluid">
    {#if can_submit && countries.size > 0}
        <form on:submit|preventDefault={pedge} class="needs-validation">
            <div class="row">
                <div class="col-md-5">
                    <Select
                        placeholder="Country you work at"
                        loadOptions={get_countries}
                        bind:value={selected_country}
                        required
                    />
                </div>
                <div class="col-md-5">
                    <div class="form-group">
                        <input
                            class="form-control"
                            type="number"
                            placeholder="hours per week"
                            min="0"
                            max="5"
                            step="0.1"
                            bind:value={hours}
                            required
                        />
                    </div>
                </div>
                <div class="col-md-2">
                    <button
                        disabled={token === null ||
                            hours === null ||
                            selected_country === null}
                        data-placement="top"
                        title={token === null ? "Fill form" : ""}
                        type="submit"
                        class="btn btn-primary"
                        data-toggle="tooltip"
                    >
                        Pledge
                    </button>
                </div>
            </div>
        </form>
        {#if selected_country !== null && explanation !== null}
            <p class="text-center">
                Not working {hours} hours per week in {countries.get(
                    selected_country["value"]
                ).name}
                reduces emissions on average by {explanation.reduced_emissions.toFixed(
                    0
                )} kg of CO2e per year,
                <strong>{explanation.multiplier.toFixed(2)}x more</strong> than recycling.
            </p>
        {/if}
        <div class="text-center" style="padding-top:1em">
            <HCaptcha
                bind:this={captcha}
                sitekey={PUBLIC_HCAPTCHA_KEY}
                on:success={isHuman}
                on:error={handleError}
            />
        </div>
    {:else}
        <p>Thank you for your pedge. Enjoy your free time.</p>
    {/if}
</div>
