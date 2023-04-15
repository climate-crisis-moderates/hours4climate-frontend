<script lang="ts">
    import { Col, Row, FormGroup, Input } from "sveltestrap";
    import Select from "svelte-select";
    import HCaptcha from "svelte-hcaptcha";

    import {
        PUBLIC_API_ENDPOINT,
        PUBLIC_HCAPTCHA_KEY,
    } from "$env/static/public";

    let countries: Array<string> = [];

    async function get_countries(text: string) {
        let base = PUBLIC_API_ENDPOINT + "/api/country";
        let url = text == "" ? base : base + "?name=" + text;

        countries = await fetch(url).then((response) => response.json());

        return countries;
    }

    let captcha: HCaptcha;

    const handleError = () => {
        captcha.reset();
    };

    // whether the pledge has been submitted (once per page)
    let can_submit = true;
    let token: string | null = null;
    let country: any = null;
    let hours: string | null = null;

    let isHuman = (event: any) => {
        token = event["detail"]["token"];
    };

    async function pedge() {
        return await fetch(PUBLIC_API_ENDPOINT + "/api/pledge", {
            method: "POST",
            body: JSON.stringify({
                token,
                country: country["value"],
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

<div>
    {#if can_submit}
        <form on:submit|preventDefault={pedge} class="needs-validation">
            <Row>
                <Col>
                    <Select
                        placeholder="Country you work at"
                        loadOptions={get_countries}
                        bind:value={country}
                        required
                    />
                </Col>
                <Col>
                    <FormGroup>
                        <Input
                            type="number"
                            placeholder="hours per week"
                            min="0"
                            max="10"
                            step="0.1"
                            bind:value={hours}
                            required
                        />
                    </FormGroup>
                </Col>
                <Col md="1">
                    <button
                        disabled={token === null ||
                            hours === null ||
                            country === null}
                        data-placement="top"
                        title={token === null ? "Fill form" : ""}
                        type="submit"
                        class="btn btn-primary"
                        data-toggle="tooltip"
                    >
                        Pledge
                    </button>
                </Col>
            </Row>
        </form>
        <div class="text-center">
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
