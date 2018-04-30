package view.interfaces
{
    import view.primeFaces.surfaceComponents.components.Div;

    /**
     * Interface related to PrimeFaces components.
     * If some component implementing it, we are exposing internal Div
     */
    public interface IDiv
    {
        function get div():Div;
    }
}
