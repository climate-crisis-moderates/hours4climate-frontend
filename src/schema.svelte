<script lang="ts" context="module">
    export type Country = {
        id: string;
        name: string;
        origin: string;
        emissions_year: number;
        emissions_unit: string;
        emissions: number;
        employees_year: number;
        employees: number;
        employees_unit: string;
    };
    export type Explanation = {
        reduced_emissions: number;
        multiplier: number;
    };

    export function build_explanation(
        countries: Map<string, Country>,
        selected_country: string,
        hours_per_week: number
    ): Explanation | null {
        let country_info = countries.get(selected_country);
        if (country_info !== undefined) {
            // 8 * 5: 8 hours a day times 5 days a week
            let reduced_emissions =
                (country_info.emissions / country_info.employees) *
                (hours_per_week / (8.0 * 5));
            // 200 kg CO2 is the reduction of emissions of recycling
            // https://www.researchgate.net/figure/A-comparison-of-the-emissions-reductions-from-various-individual-actions-The-height-of_fig1_318353145
            let multiplier = reduced_emissions / 200;
            return {
                reduced_emissions,
                multiplier,
            };
        } else {
            return null;
        }
    }
</script>
