package view.interfaces
{
    import view.domino.surfaceComponents.components.DominoSection;

    /**
     * Interface related to PrimeFaces components.
     * If some component implementing it, we are exposing internal Div
     */
    public interface IDominoSection
    {
        function get dominoSection():IDominoSection;
    }
}